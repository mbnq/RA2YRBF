import configparser
import tkinter as tk
from tkinterdnd2 import TkinterDnD, DND_FILES

def get_sections_with_crategoodie(file_path):
    config = configparser.ConfigParser()
    config.read(file_path)
    
    matching_sections = []
    
    for section in config.sections():
        if 'CrateGoodie' in config[section]:
            value = config[section]['CrateGoodie']
            if value.lower() in ['yes', 'true']:
                matching_sections.append(section)
    
    return matching_sections

def on_drop(event):
    file_path = event.data.strip('{}')
    sections = get_sections_with_crategoodie(file_path)
    result_text.delete(1.0, tk.END)
    formatted_sections = "\n".join([f"[{section}]" for section in sections])
    result_text.insert(tk.END, formatted_sections)

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
