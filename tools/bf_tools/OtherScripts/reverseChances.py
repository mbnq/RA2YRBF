import re

def update_reroll_chances(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    pattern = re.compile(r'CrateGoodie\.RerollChance=(\d\.\d+)')
    updated_lines = []

    for line in lines:
        match = pattern.search(line)
        if match:
            current_value = float(match.group(1))
            new_value = 1.00 - current_value
            updated_line = pattern.sub(f'CrateGoodie.RerollChance={new_value:.2f}', line)
            updated_lines.append(updated_line)
        else:
            updated_lines.append(line)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.writelines(updated_lines)

if __name__ == "__main__":
    file_path = r'F:\projekty\_cnc_\RA2BruteForce\python\bfLoot.ini'  # Use raw string to avoid issues with backslashes
    update_reroll_chances(file_path)
