#!/usr/bin/env python
# This Python file uses the following encoding: utf-8
import sys
import datetime
import os
from pathlib import Path

import rospy


from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Signal, Slot, QTimer, QUrl


class MainWindow(QObject):

    def __init__(self):
        QObject.__init__(self)
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)

    # Signals will be sent to QML
    setName = Signal(str)  # for setting the new name

    printDate = Signal(str)  # for sending now time

    isVisible = Signal(bool)

    readText = Signal(str)

    setUser = Signal(str)

    textField = ""
    username = ""
    # Slots will be the port for data coming from home page

    @Slot(bool)
    def getUsername(self, dummy):
        self.setUser.emit(self.username)

    @Slot(str)
    def getTextFile(self, text):
        self.textField = text

    @Slot(str)
    def writeFile(self, fileUrl):
        file = open(QUrl(fileUrl).toLocalFile(), "w")
        file.write(self.textField)
        file.close()
        print(self.textField)

    @Slot(str)
    def welcome_text(self, name):
        # home page submit button onClicked function will active this
        # signal. this on the other hand will send an string signal or
        # data to the QML.
        self.setName.emit("Welcome, " + name)

    @Slot(str)
    def saveUsername(self, username):
        self.username = username

    @Slot(bool)
    def showHideRectangle(self, isChecked):
        #        print(f"Is rectangle visible: {isChecked}")
        visible = True if isChecked else False
        self.isVisible.emit(visible)

    @Slot(str)
    def openFile(self, fileUrl):
        file = open(QUrl(fileUrl).toLocalFile(), encoding="utf-8")
        text = file.read()
        file.close
        print(text)
        self.readText.emit(str(text))

    def setTime(self):
        now = datetime.datetime.now()
        formatted_date = now.strftime("Now is %H:%M:%S %p of %Y/%m/%d")
        self.printDate.emit(formatted_date)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    rospy.init_node('qml_ros_node')

    # Creating the Context. Context is a part of the python program acting as the backend of the application
    # We say this to the 'engine' by setting the context. After that requests from the QML be gotten by the engine
    # and given to context and the results will be sent back to QML frontend. It also is like the name of connection bus
    # between the QML and python or backend.
    main = MainWindow()  # the class works with data from qt tools

    engine.rootContext().setContextProperty("backend", main)

    # loading qml file
    qml_file = Path(__file__).resolve().parent / "qml/main.qml"
    engine.load(str(qml_file))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
