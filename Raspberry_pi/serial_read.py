# -*- coding: UTF-8 -*-
import urllib.request
import serial
import re
import threading
import datetime,sys

try:
  # 変数用意
  # Arduinoのデバイス名を変数
  ser = serial.Serial('/dev/ttyACM0')
  while True:
    line = ser.readline().decode('utf-8')
    print(line)
    hoge = line.split(" ")
    if len(hoge) >= 2:
        # 温度の値を取得
        if hoge[0] == "Temperature":
          # 正規表現を使って数字だけ抽出
          integer = re.match(".\d*",hoge[1])
          inte = integer.group()
          temp = inte
          chk_temp = True
        # 湿度の値を取得
        if hoge[0] == "Humidity":
          chk_temp = False
          # 正規表現を使って数字だけ抽出
          integer = re.match(".\d*",hoge[1])
          inte = integer.group()
          humi = inte
    t = datetime.datetime.today().time()
    if 0 <= t.second <= 2:
        #　サーバーにデータ送信
        print("Send Status...Temp:"+temp+", humi:"+humi)
        url = "http://kitf1.dip.jp/status/create/1/"+temp+"/"+humi
        # urllib.request.urlopen(url)
except KeyboardInterrupt:
  print("detect key interrupt\n")
