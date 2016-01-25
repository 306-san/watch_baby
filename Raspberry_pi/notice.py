# -*- coding: UTF-8 -*-
import urllib.request
import RPi.GPIO as GPIO
import time

#GPIOピン番号を用いる
GPIO.setmode(GPIO.BCM)
GPIO.setup(23, GPIO.OUT)
GPIO.setwarnings(False)
try:
    while True:
        print(GPIO.input(23))
        time.sleep(1)
        if GPIO.input(23) == 1:
            print("ok..connect...server...")
            response = urllib.request.urlopen('http://kitf1.dip.jp/home/call/1')
            
except KeyboardInterrupt:
    print("detect key interrupt\n")

GPIO.cleanup()
print("Program exit\n")
