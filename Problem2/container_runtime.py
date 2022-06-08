import sys
import os

def start():

    l = len(sys.argv)
    try:
        if l == 2:
            os.system(f"python ./CLI.py {sys.argv[1]}")
        elif l == 3:
            os.system("chmod +x ./start_CLI.sh")
            os.system(f"systemd-run --scope -p MemoryLimit={sys.argv[2]}M ./start_CLI.sh {sys.argv[1]}")
    except:
        print("we should have one or two arguments.")
    


if __name__=='__main__':
    start()