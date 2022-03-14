import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import '../controls'

Item {

    Rectangle {
        id: bgSettings
        color: "#2c313c"
        anchors.fill: parent
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        Rectangle {
            id: bgTitle
            width: 200
            height: 50
            color: "#495163"
            radius: 10
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 25
            Label {
                id: settingsLabel
                x: 10
                y: 66
                color: "#ffffff"
                text: qsTr("Меню настроек")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 10
                anchors.leftMargin: 10
                font.pointSize: 18
                anchors.rightMargin: 10
                anchors.bottomMargin: 10
            }
            anchors.leftMargin: 25
        }

        Rectangle {
            id: bgStart
            width: 842
            height: 132
            color: "#1d2128"
            radius: 10
            anchors.left: parent.left
            anchors.top: bgTitle.bottom
            anchors.topMargin: 25
            Label {
                id: labelStart
                x: 8
                y: 8
                color: "#ffffff"
                text: qsTr("Настройки запуска")
                font.styleName: "Обычный"
                font.pointSize: 16
            }

            Label {
                id: labelAutorun
                color: "#ffffff"
                text: qsTr("Автоматически запускать Hardware Monitor после включения компьютера")
                anchors.left: parent.left
                anchors.top: labelStart.bottom
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 10
                anchors.topMargin: 15
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                font.pointSize: 14
                Layout.preferredHeight: 22
            }

            CustomCombobox {
                id: comboAutorun
                x: 676
                width: 150
                height: 30
                anchors.verticalCenter: labelAutorun.verticalCenter
                anchors.right: parent.right
                font.pointSize: 12
                anchors.rightMargin: 15
                model: ['Нет', 'Да', 'В свернутом виде']
                onActivated: {
                    backend.getSettings('autorun', comboAutorun.currentText, true, 'smth')
                }
            }

            Label {
                id: labelMinimize
                color: "#ffffff"
                text: qsTr("При нажатии кнопки Закрыть сворачивать окно Hardware Monitor")
                anchors.left: parent.left
                anchors.top: labelAutorun.bottom
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 10
                anchors.leftMargin: 10
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                font.pointSize: 14
                Layout.preferredHeight: 22
                
            }

            Switch {
                id: switchMinimize
                x: 745
                text: ""
                anchors.verticalCenter: labelMinimize.verticalCenter
                anchors.right: parent.right
                scale: 1.5
                anchors.rightMargin: 20
                font.pointSize: 12
                onToggled: {
                    backend.getSettings('minimize', 'smth', switchMinimize.checked, 'smth')
                }
            }
            anchors.leftMargin: 17
        }

        Rectangle {
            id: bgWork
            y: 252
            width: 581
            height: 132
            color: "#1d2128"
            radius: 10
            anchors.left: parent.left
            anchors.top: bgTitle.bottom
            anchors.topMargin: 177
            Label {
                id: labelWork
                x: 8
                y: 8
                width: 185
                height: 28
                color: "#ffffff"
                text: qsTr("Настройки работы")
                font.pointSize: 16
            }

            Label {
                id: labelFrequency
                color: "#ffffff"
                text: qsTr("Частота отправки данных на микроконтроллер")
                anchors.left: parent.left
                anchors.top: labelWork.bottom
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 15
                font.pointSize: 14
                anchors.leftMargin: 10
                Layout.preferredHeight: 22
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }

            Label {
                id: labelSmth
                color: "#ffffff"
                text: qsTr("Тут пока что пусто")
                anchors.left: parent.left
                anchors.top: labelFrequency.bottom
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 10
                font.pointSize: 14
                anchors.leftMargin: 10
                Layout.preferredHeight: 22
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }

            Switch {
                id: switchSmth
                x: 745
                text: ""
                anchors.verticalCenter: labelSmth.verticalCenter
                anchors.right: parent.right
                scale: 1.5
                font.pointSize: 12
                anchors.rightMargin: 20
            }

            CustomTextField {
                id: textFrequency
                y: 54
                height: 23
                anchors.verticalCenter: labelFrequency.verticalCenter
                anchors.left: labelFrequency.right
                anchors.right: parent.right
                antialiasing: true
                layer.smooth: false
                scale: 1.1
                anchors.rightMargin: 15
                anchors.verticalCenterOffset: 2
                anchors.leftMargin: 20
                placeholderText: qsTr("Пиши секунды")
                validator: IntValidator {bottom: 0; top: 999999;}
                onEditingFinished: {
                    backend.getSettings('frequency', 'smth', true, textFrequency.displayText)
                }
            }
            anchors.leftMargin: 17
        }

        Rectangle {
            id: bgApply
            width: 234
            height: 95
            color: "#1d2128"
            radius: 10
            anchors.verticalCenter: bgWork.verticalCenter
            anchors.left: bgWork.right
            anchors.leftMargin: 25

            CustomButton {
                id: btnApplySettings
                text: "Применить"
                anchors.fill: parent
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.bottomMargin: 25
                anchors.topMargin: 25
                Layout.fillWidth: true
                font.pointSize: 14
                Layout.preferredWidth: 250
                Layout.preferredHeight: 40
                Layout.maximumWidth: 200
                onClicked: {
                    backend.applySettings()
                }
            }
        }
        Connections {
            target: backend

            
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:500;width:900}D{i:3}D{i:2}D{i:5}D{i:6}D{i:7}D{i:8}D{i:9}
D{i:4}D{i:11}D{i:12}D{i:13}D{i:14}D{i:15}D{i:10}D{i:17}D{i:16}D{i:18}D{i:1}
}
##^##*/
