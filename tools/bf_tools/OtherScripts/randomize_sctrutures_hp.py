import os
import random
import configparser

class NoSpaceConfigParser(configparser.ConfigParser):
    def write(self, fp, space_around_delimiters=False):
        if space_around_delimiters:
            super().write(fp, space_around_delimiters)
        else:
            for section in self.sections():
                fp.write(f"[{section}]\n")
                for key, value in self.items(section, raw=True):
                    fp.write(f"{key}={value}\n")
                fp.write("\n")

def modify_structures_section(file_path, range_start=96, range_end=192):

    config = NoSpaceConfigParser(allow_no_value=True)
    config.optionxform = str
    config.read(file_path)
    
    if 'Structures' in config:
        for key in config['Structures']:
            if key == 'CABHUT':
                continue  # Ignore the key 'CABHUT'
            values = config['Structures'][key].split(',')
            if len(values) >= 3:
                values[2] = str(random.randint(range_start, range_end))
                config['Structures'][key] = ','.join(values)
        
        with open(file_path, 'w') as configfile:
            config.write(configfile, space_around_delimiters=False)

def process_files_in_directory(directory, range_start=96, range_end=192):

    for filename in os.listdir(directory):
        if filename.endswith('structures.txt') or filename.endswith('structures.ini'):
            file_path = os.path.join(directory, filename)
            modify_structures_section(file_path, range_start, range_end)

# Example usage
if __name__ == "__main__":
    script_directory = os.path.dirname(os.path.abspath(__file__))
    print("Brute Force - www.mbnq.pl\n\n")
    print("This script will randomize HP of structures in structures.txt\nor structures.ini file.\n")

    user_range_start = int(input("Enter the start of the range (default 96): ") or 96)
    user_range_end = int(input("Enter the end of the range (default 192): ") or 192)
    
    process_files_in_directory(script_directory, user_range_start, user_range_end)
    print("Modification completed.")
    
    # Wait for user to press any key before exiting
    input("Press any key to quit...")
