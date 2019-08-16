#!/usr/bin/python 
''' Run connection test to run hue only when mysql is already started  '''

hostname = 'database'
username = 'root'
password = 'secret'
database = 'hue' 
import MySQLdb
from time import sleep
from subprocess import call

result = None

while result is None:
    try:
        myConnection = MySQLdb.connect(host=hostname, user=username, passwd=password, db=database)
        cur = myConnection.cursor()
        cur.execute("SELECT version()")
        result = cur.fetchone()
    except Exception as e:
        print(str(e))
        pass

print("Running HUE startup script...")
call("./startup.sh")