import os
import sys

def create_container():
    ind = 1
    while(os.path.isdir(f"chroot-jail{ind}")):
        ind += 1
    os.mkdir(f'chroot-jail{ind}')
    os.system(f"cp -r ./chroot-jail/* ./chroot-jail{ind}/")
    with open(f'./chroot-jail{ind}/start.sh', 'w') as start:
        start.write("#!/bin/bash\n")
        start.write(f"hostname {sys.argv[1]}\n")
        start.write("mount -t proc proc /proc")
    os.system(f"unshare --net --mount --pid --uts --fork --map-root-user --mount-proc bash -c \"./CLI.sh {ind}\"")

if __name__=='__main__':
    create_container()