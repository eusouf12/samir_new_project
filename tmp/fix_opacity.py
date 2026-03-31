import os
import re

def fix_with_opacity(root_dir):
    pattern = re.compile(r'\.withOpacity\((.*?)\)')
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, 'r') as f:
                        content = f.read()
                    
                    new_content = pattern.sub(r'.withValues(alpha: \1)', content)
                    
                    if new_content != content:
                        with open(file_path, 'w') as f:
                            f.write(new_content)
                        print(f"Fixed {file_path}")
                except Exception as e:
                    print(f"Error processing {file_path}: {e}")

if __name__ == "__main__":
    fix_with_opacity('lib')
