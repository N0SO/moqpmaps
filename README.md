# MOQPMAPS
OpenStreetMaps County activation and route planning for the Missouri QSO Party.

## Requirements
1. Linux host (Raspberry Pi or cloud based VM)
2. Python3.
3. Pip3.
4. MySQL or MariaDB MYSQL database server and client.
5. Python3-flask
6. Python3-PyMySQL

The python specific requirements may be found  in the file requirements.txt.

## Installation
1. Setup the Linux host and make sure it's up to date. On a Raspberry Pi, get
   the latest image and install it, then perform updates (sudo apt update; 
   sudo apt upgrade). 
2. Install mysql-server or mariadb-server: sudo apt install mysql-server 
3. Install the files for this repository in a folder of your choosing.
4. Setup python as a virtual environment in the folder you put the same folder
   you put the repo files in: python -m venv .venv
5. Activate your virtual python: ./venv/bin/activate
6. Install the python required modules: pip install requirements.txt


