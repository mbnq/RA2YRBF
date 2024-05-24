import configparser
import tkinter as tk
from tkinterdnd2 import TkinterDnD, DND_FILES

def add_reroll_chance_to_sections(file_path):
    config = configparser.ConfigParser()
    config.read(file_path)
    
    for section in config.sections():
        config.set(section, 'CrateGoodie.RerollChance', '0.50')
    
    with open(file_path, 'w') as configfile:
        config.write(configfile)
    
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
