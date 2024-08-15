import time
import subprocess
import threading

# Colors
GREEN = '\033[92m'
YELLOW = '\033[93m'
RED = '\033[91m'
RESET = '\033[0m'


def run_script(script_name, script_path, color, optionalCmd=''):
    chars = ['|', '/', '-', '\\']
    
    def animate():
        # This function will animate the running of the script
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
        # Run the script and check if it was successful
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
    
    # Print the result and reset the color of the text
    print(f'\n{fcolor}{result_char} | {result_text} - {script_name}')
    print(RESET, end='', flush=True)


run_script('DataSpliter.ipynb', '', YELLOW, [ "jupyter", "execute", "data/DataSpliter.ipynb"])
run_script('file.py','./scripts/postgres.py', YELLOW)
run_script('SSIS > package,dtsx','', YELLOW, ['dtexec', '/F', 'ssis/package.dtsx'])

