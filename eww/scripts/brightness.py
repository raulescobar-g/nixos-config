#!/usr/bin/env python
from subprocess import run, PIPE

def main():
    get_brightness_cmd = "brightnessctl g"
    total_brightness_cmd = "brightnessctl m"

    brightness_output = float(run(get_brightness_cmd, shell=True, stdout=PIPE).stdout.strip().decode('ascii'))
    total_output = float(run(total_brightness_cmd, shell=True, stdout=PIPE).stdout.strip().decode('ascii'))

    brightness = int((brightness_output / total_output) * 100.0)

    return f"{brightness} br".rjust(5)

if __name__ == "__main__":
    print(main())


