 # ____             _         ______                 
 # |  _ \           | |       |  ____|                
 # | |_) |_ __ _   _| |_ ___  | |__ ___  _ __ ___ ___ 
 # |  _ <| '__| | | | __/ _ \ |  __/ _ \| '__/ __/ _ \
 # | |_) | |  | |_| | ||  __/ | | | (_) | | | (_|  __/
 # |____/|_|   \__,_|\__\___| |_|  \___/|_|  \___\___|
                                                    
 # mbnq00@gmail.com
 # https://www.mbnq.pl/


 # .ini 	Version: 0.8.4336
 #  mod	    Version: 0.8.4336

 # Use it with valid_all.bat to check for basic syntax errors
 # _____________________________________________________________________________________

import configparser
import os

def check_ini_file(file_path):
    """
    Check the .ini file for syntax errors and other common issues.
    Args:
    - file_path (str): Path to the .ini file.
    
    Returns:
    - errors (list): List of error messages found in the file.
    """
    config = configparser.ConfigParser(strict=False)
    errors = []

    # Check if the file exists
    if not os.path.isfile(file_path):
        errors.append(f"File not found: {file_path}")
        return errors

    try:
        # Attempt to read the file
        with open(file_path, 'r') as f:
            config.read_file(f)
    except configparser.DuplicateOptionError as e:
        errors.append(f"Duplicate option error: {e}")
        return errors
    except configparser.ParsingError as e:
        errors.append(f"Parsing error: {e}")
        return errors
    except configparser.InterpolationSyntaxError as e:
        errors.append(f"Interpolation syntax error: {e}")
        return errors

    # Check for sections
    if not config.sections():
        errors.append("No sections found in the file.")

    for section in config.sections():
        # Check for duplicate keys within sections
        seen_keys = set()
        for key in config[section]:
            if key in seen_keys:
                errors.append(f"Duplicate key '{key}' found in section '{section}'.")
            seen_keys.add(key)

    return errors

def check_ini_directory(directory_path):
    """
    Check all .ini files in the specified directory.
    Args:
    - directory_path (str): Path to the directory containing .ini files.
    
    Returns:
    - result (dict): Dictionary with filenames as keys and lists of error messages as values.
    """
    result = {}
    for filename in os.listdir(directory_path):
        if filename.endswith(".ini"):
            file_path = os.path.join(directory_path, filename)
            errors = check_ini_file(file_path)
            if errors:
                result[filename] = errors

    return result

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Check .ini files for syntax and other errors.")
    parser.add_argument("path", help="Path to the .ini file or directory containing .ini files")
    args = parser.parse_args()

    if os.path.isdir(args.path):
        result = check_ini_directory(args.path)
        for filename, errors in result.items():
            print(f"Errors in {filename}:")
            for error in errors:
                print(f"  - {error}")
    elif os.path.isfile(args.path) and args.path.endswith(".ini"):
        errors = check_ini_file(args.path)
        if errors:
            print(f"Errors in {args.path}:")
            for error in errors:
                print(f"  - {error}")
        else:
            print(f"No errors found in {args.path}")
    else:
        print("Invalid path. Please provide a path to a .ini file or a directory containing .ini files.")
