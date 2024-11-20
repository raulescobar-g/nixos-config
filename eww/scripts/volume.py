#!/usr/bin/env python
from subprocess import run, PIPE

def main():
    cmd = """amixer get Master | grep -o "[0-9]*%" | head -n 1 | sed 's/%//g'"""
    command_output = run(cmd, shell=True, stdout=PIPE)
    output = command_output.stdout.strip().decode('ascii')
    return f"{output}  ".rjust(5)

if __name__ == "__main__":
    print(main())


