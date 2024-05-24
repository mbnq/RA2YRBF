import tkinter as tk
from tkinterdnd2 import TkinterDnD, DND_FILES
import re

def add_reroll_chance_to_sections(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    new_lines = []
    section_pattern = re.compile(r'^\[(.*)\]$')
    key_added_sections = set()
    current_section = None

    for line in lines:
        # Detect section headers
        section_match = section_pattern.match(line.strip())
        if section_match:
            current_section = section_match.group(1)
        
        # Add the CrateGoodie.RerollChance key if not already added for the section
        if current_section and current_section not in key_added_sections:
            if line.strip().startswith('[') and line.strip().endswith(']'):
                new_lines.append(line)
                new_lines.append('CrateGoodie.RerollChance=0.50\n')
                key_added_sections.add(current_section)
            else:
                new_lines.append(line)
        else:
            new_lines.append(line)

    # Ensure the last section gets the new key if it was not added
    if current_section and current_section not in key_added_sections:
        new_lines.append('CrateGoodie.RerollChance=0.50\n')

    with open(file_path, 'w') as file:
        file.writelines(new_lines)
    
    return file_path

def on_drop(event):
    file_path = event.data.strip('{}')
    updated_file_path = add_reroll_chance_to_sections(file_path)
    result_text.delete(1.0, tk.END)
    result_text.insert(tk.END, f"Updated file saved at: {updated_file_path}")

# Set up the main application window
root = TkinterDnD.Tk()
root.title("Drag and Drop .ini File")

# Create a label to instruct the user
label = tk.Label(root, text="Drag and drop your .ini file here")
label.pack(pady=20)

# Create a Text widget to hold the result
result_text = tk.Text(root, wrap=tk.WORD, width=60, height=10)
result_text.pack(pady=20)

# Set up the drop target
root.drop_target_register(DND_FILES)
root.dnd_bind('<<Drop>>', on_drop)

# Start the Tkinter main loop
root.geometry("600x400")
root.mainloop()
