#!/usr/bin/env python
import psutil

def main():
    battery = psutil.sensors_battery()
    percent = int(battery.percent)
    return f"{percent}  ".rjust(5)

if __name__ == "__main__":
    print(main())


