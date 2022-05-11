# This Python file uses the following encoding: utf-8
import os
import sys
import wmi
import time
from pathlib import Path

from fetch_data import getData
from arduino import serialSendDict, serialSendInt
from arduino import onOpen, getPorts, makeSelectedInt

from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QObject, Slot, Signal, QThread
from PySide6.QtQml import QQmlApplicationEngine


# Предварительное объявление переменных
count = 0
freq = 1
disk_list = []
selected = []
ports = []
data = {}

# Получение списков доступных для работы портов и дисков
ports = getPorts()
hwmon = wmi.WMI()
disks = hwmon.Win32_DiskDrive()
for d in disks:
    disk_list.append(d.Caption)


# Объявление потока для обновления данных
class Thread(QThread):

    sendData = Signal(dict)
    sendPrint = Signal(list)

    def __init__(self):
        super(Thread, self).__init__()

    def __del__(self):
        self.wait()

    def run(self):
        global infinity, freq

        infinity = 'not the limit'

        # Получение и отправка данных в бесконечном цикле
        while infinity == 'not the limit':
            time.sleep(freq)
            data = getData()
            bye = True
            if data is not None:
                if data != 'RunHWMon':
                    self.sendData.emit(data)
                    self.sendPrint.emit(['print'])
                else:
                    self.sendPrint.emit(['runHW'])
                    infinity = 'limit'
                    bye = False

        if bye:
            self.sendPrint.emit(['bye'])


# Объявление класса приложения
class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    isChecked = Signal(bool)
    countLimit = Signal(bool)
    driveModelList = Signal(list)
    portsModelList = Signal(list)

    # Функция для отправки данных на микроконтроллер
    def sendDataToArduino(self, data):
        if type(data) == dict:
            serialSendDict(data)
        elif type(data) == list:
            serialSendInt(data)

    # Функция обработки нажатия кнопки 'Apply'
    @Slot()
    def applyButton(self):
        if count > 0:
            # На микроконтроллер передается список выбранных параметров
            serialSendInt(makeSelectedInt(selected, disk_list))

            # Запуск потока для обновления данных
            self.thread = Thread()
            self.thread.sendData.connect(self.sendDataToArduino)
            self.thread.sendPrint.connect(self.sendDataToArduino)
            self.thread.start()

    # Функция обработки нажатия кнопки 'Stop'
    @Slot()
    def stopButton(self):
        global infinity

        # Изменение основного условия бесконечного цикла
        infinity = 'limit'

    # Функция открытия нужного серийного порта
    @Slot(str)
    def openPort(self, port):
        if port == 'Choose':
            print('You didnt make choise')
        elif port == 'None':
            print('You didnt connect any device')
        else:
            onOpen(port)

    # Функция обработки введенного значения частоты обновления
    @Slot(int)
    def getSettings(self, frequency):
        global freq
        freq = frequency

    # Функция обработки выбора диска
    @Slot()
    def getDriveComboBox(self):
        self.driveModelList.emit(list(disk_list))

    # Функция обработки выбора порта
    @Slot()
    def getPortsComboBox(self):
        self.portsModelList.emit(list(ports))

    # Функция обработки выбора параметров
    @Slot(bool, str, str)
    def returnStatus(self, isChecked, name, destiny):
        global count
        counter = 0

        if destiny == 'ForDecency':
            if isChecked and count < 4:
                count += 1
                selected.append(name)
                if count == 4:
                    self.countLimit.emit(True)
            elif isChecked is False and count <= 4:
                count -= 1
                selected.remove(name)
                if count == 3:
                    self.countLimit.emit(False)
        else:
            if isChecked is False:
                for sel in reversed(selected):
                    if sel.startswith('Used Space'):
                        counter += 1
                        selected.remove(sel)
                    elif sel.startswith('Rate'):
                        counter += 2
                        selected.remove(sel)
                count -= counter
                self.countLimit.emit(False)

    # Функция обработки выбора параметров, касающихся дисков
    @Slot(str, str)
    def returnDiskStatus(self, destination, chosenOne):
        global count
        chosenOne = destination + chosenOne

        if destination == 'Rate ':
            if chosenOne not in selected and count < 3:
                count += 2
                selected.append(chosenOne)
                if count == 4:
                    self.countLimit.emit(True)
            elif chosenOne in selected and count <= 4:
                count -= 2
                selected.remove(chosenOne)
                if count == 2:
                    self.countLimit.emit(False)
        else:
            if chosenOne not in selected and count < 4:
                count += 1
                selected.append(chosenOne)
                if count == 4:
                    self.countLimit.emit(True)
            elif chosenOne in selected and count <= 4:
                count -= 1
                selected.remove(chosenOne)
                if count == 3:
                    self.countLimit.emit(False)


# Если приложение запущено напрямую, то запустится приложение
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    main = MainWindow()

    engine.rootContext().setContextProperty('backend', main)
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
