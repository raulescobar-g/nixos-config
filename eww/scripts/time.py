#!/usr/bin/env python
from datetime import datetime

def main():
    now = datetime.now()
    return now.strftime("%H:%M").rjust(5)

if __name__ == "__main__":
    print(main())


