# This Python file uses the following encoding: utf-8
import os
import sys
import wmi
import time
import json
from pathlib import Path

from fetch_data import getData
from arduino import serialSendDict, serialSendInt
from arduino import onOpen, getPorts, makeSelectedInt

from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QObject, Slot, Signal, QRunnable, QThreadPool
from PySide6.QtQml import QQmlApplicationEngine


count = 0
freq = 1
disk_list = []
selected = []
ports = []
data = {}

ports = getPorts()
hwmon = wmi.WMI()
disks = hwmon.Win32_DiskDrive()
for d in disks:
    disk_list.append(d.Caption)


class Worker(QRunnable):
    def __init__(self):
        super(Worker, self).__init__()

    @Slot()
    def run(self):
        global infinity
        global freq

        infinity = 'not the limit'

        while infinity == 'not the limit':
            time.sleep(freq)
            data = getData()
            if data is not None:
                serialSendDict(data)
                serialSendInt(['print'])


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        self.threadpool = QThreadPool()
        self.threadpool.setMaxThreadCount(1)

    isChecked = Signal(bool)
    countLimit = Signal(bool)
    driveModelList = Signal(list)
    portsModelList = Signal(list)

    @Slot()
    def applyButton(self):
        if count > 0:
            serialSendInt(makeSelectedInt(selected, disk_list))
            worker = Worker()
            self.threadpool.start(worker)

    @Slot()
    def stopButton(self):
        global infinity

        infinity = 'limit'
        serialSendInt(['bye', '97'])

    @Slot(str)
    def openPort(self, port):
        if port == 'Choose':
            print('You didnt make choise')
        elif port == 'None':
            print('You didnt connect any device')
        else:
            onOpen(port)

    @Slot(int)
    def getSettings(self, frequency):
        global freq
        freq = frequency

    @Slot()
    def getDriveComboBox(self):
        self.driveModelList.emit(list(disk_list))

    @Slot()
    def getPortsComboBox(self):
        self.portsModelList.emit(list(ports))

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
        print(selected)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    main = MainWindow()

    engine.rootContext().setContextProperty('backend', main)
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
