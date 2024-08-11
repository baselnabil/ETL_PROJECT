import time
import subprocess
import threading

GREEN = '\033[92m'
YELLOW = '\033[93m'
RED = '\033[91m'
RESET = '\033[0m'

def run_script(script_name, script_path, color, optionalCmd=''):
    chars = ['|', '/', '-', '\\']
    
    def animate():
        while still_processing:
            for char in chars:
                if not still_processing:
                    break
                print(f'\r{color}{char} | Trying to run {script_name}...', end='', flush=True)
                time.sleep(0.15)

    still_processing = True
    animation_thread = threading.Thread(target=animate)
    animation_thread.start()
    
    try:
        time.sleep(0.3)
        if optionalCmd == '':
            subprocess.run(['python', script_path], check=True)
        else: 
            subprocess.run(optionalCmd, check=True)
        result_char = '✔'
        result_text = 'Successfully ran'
        fcolor = GREEN
    except subprocess.CalledProcessError:
        result_char = '✘'
        result_text = 'Failed to run'
        fcolor = RED
    finally:
        still_processing = False
        animation_thread.join()
    

    print(f'\n{fcolor}{result_char} | {result_text} - {script_name}')
    print(RESET, end='', flush=True)


run_script('DataSpliter.ipynb', '', YELLOW, [ "jupyter", "execute", "data/DataSpliter.ipynb"])
run_script('file.py','./scripts/postgres.py', YELLOW)
