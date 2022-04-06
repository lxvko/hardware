import QtQuick
import QtQuick.Controls

Item {
    id: item1
    Rectangle {
        id: background
        color: "#2c313c"
        anchors.fill: parent
        Rectangle {
            id: bgTitle
            width: 333
            height: 50
            color: "#495163"
            radius: 10
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.leftMargin: 25

            Label {
                id: aboutLabel
                x: 10
                y: 66
                color: "#ffffff"
                text: qsTr("Информация о программе")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 10
                anchors.bottomMargin: 10
                anchors.leftMargin: 10
                anchors.topMargin: 10
                font.pointSize: 18
            }
        }

        Rectangle {
            id: bgAbout
            width: 520
            height: 306
            color: "#1d2128"
            radius: 10
            anchors.left: parent.left
            anchors.top: bgTitle.bottom
            anchors.leftMargin: 25
            anchors.topMargin: 25

            Label {
                id: name
                color: "#ffffff"
                text: qsTr("Мониторинг технических параметров ПК")
                anchors.left: parent.left
                anchors.top: diplom.bottom
                anchors.leftMargin: 15
                anchors.topMargin: 5
                font.pointSize: 14
            }

            Label {
                id: myname
                color: "#ffffff"
                text: qsTr("Разработал: Дон Михаил Дмитриевич")
                anchors.left: parent.left
                anchors.top: separator1.bottom
                font.pointSize: 14
                anchors.leftMargin: 15
                anchors.topMargin: 13
            }

            Label {
                id: diplom
                color: "#ffffff"
                text: qsTr("Разработано для дипломного проекта")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pointSize: 14
                anchors.leftMargin: 15
                anchors.topMargin: 20
            }

            Label {
                id: rukname
                color: "#ffffff"
                text: qsTr("Дипломный руководитель: Неволина Елена Валерьевна")
                anchors.left: parent.left
                anchors.top: myname.bottom
                verticalAlignment: Text.AlignTop
                font.pointSize: 14
                anchors.leftMargin: 15
                anchors.topMargin: 5
            }

            Rectangle {
                id: separator1
                height: 3
                color: "#495163"
                radius: 1.5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: name.bottom
                anchors.topMargin: 15
                anchors.rightMargin: 10
                anchors.leftMargin: 10
            }

            Rectangle {
                id: separator2
                height: 3
                color: "#495163"
                radius: 1.5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rukname.bottom
                anchors.leftMargin: 10
                anchors.topMargin: 15
                anchors.rightMargin: 10
            }

            Label {
                id: backend
                color: "#ffffff"
                text: qsTr("Back-end: Python")
                anchors.left: parent.left
                anchors.top: frontend.bottom
                font.pointSize: 14
                anchors.leftMargin: 15
                anchors.topMargin: 5
            }

            Label {
                id: frontend
                y: 197
                color: "#ffffff"
                text: qsTr("Front-end: QML ")
                anchors.left: parent.left
                anchors.top: separator2.bottom
                verticalAlignment: Text.AlignTop
                font.pointSize: 14
                anchors.leftMargin: 15
                anchors.topMargin: 13
            }

            Label {
                id: created
                color: "#ffffff"
                text: qsTr("Скомпилировано: 06.04.2022")
                anchors.left: parent.left
                anchors.top: backend.bottom
                font.pointSize: 14
                anchors.leftMargin: 15
                anchors.topMargin: 5
            }
        }

        Image {
            id: image
            width: 300
            height: 300
            anchors.verticalCenter: bgAbout.verticalCenter
            anchors.left: bgAbout.right
            source: "../../images/logo.png"
            anchors.leftMargin: 20
            sourceSize.height: 200
            sourceSize.width: 200
            fillMode: Image.PreserveAspectFit
        }
    }

}
/*##^##
Designer {
    D{i:0;autoSize:true;height:500;width:900}D{i:3}D{i:2}D{i:5}D{i:6}D{i:7}D{i:8}D{i:9}
D{i:10}D{i:11}D{i:12}D{i:13}D{i:4}D{i:14}D{i:1}
}
##^##*/
