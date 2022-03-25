import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import '../controls'

Item {

    Rectangle {
        id: bgHome
        color: "#2c313c"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: bgTitle
            width: 474
            height: 50
            color: "#495163"
            radius: 10
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.leftMargin: 25

            Label {
                id: homeLabel
                x: 10
                y: 66
                color: "#ffffff"
                text: qsTr("Выбери не больше четырех параметров")
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
            id: bgCPU
            width: 252
            height: 132
            color: "#1d2128"
            radius: 10
            anchors.left: parent.left
            anchors.top: bgTitle.bottom
            anchors.leftMargin: 17
            anchors.topMargin: 25

            Label {
                id: labelCPU
                x: 8
                y: 8
                color: "#ffffff"
                text: qsTr("CPU")
                font.pointSize: 16
            }

            RowLayout {
                id: rowCpuLoad
                x: 5
                y: 44

                Switch {
                    id: switchCpuLoad
                    text: ""
                    font.pointSize: 12

                    onToggled: {
                        backend.returnStatus(switchCpuLoad.checked, 'CpuLoad', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Температура и загрузка ЦП в процентах ")

                }

                Label {
                    id: labelCpuLoad
                    color: "#ffffff"
                    text: qsTr("Загрузка ЦП")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
                

            }

            RowLayout {
                id: rowCpuClocks
                anchors.left: parent.left
                anchors.top: rowCpuLoad.bottom
                anchors.leftMargin: 5
                anchors.topMargin: 5
                Switch {
                    id: switchCpuClocks
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.returnStatus(switchCpuClocks.checked, 'CpuClocks', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Средняя рабочая частота ядер ЦП ")
                }

                Label {
                    id: labelCpuClocks
                    color: "#ffffff"
                    text: qsTr("Частоты ядра")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }
        }

        Rectangle {
            id: bgGPU
            width: 252
            height: 169
            color: "#1d2128"
            radius: 10
            anchors.left: parent.left
            anchors.top: bgCPU.bottom
            anchors.topMargin: 20
            anchors.leftMargin: 17
            Label {
                id: labelGPU
                x: 8
                y: 8
                color: "#ffffff"
                text: qsTr("GPU")
                font.pointSize: 16
            }

            RowLayout {
                id: rowGpuLoad
                x: 5
                y: 44
                Switch {
                    id: switchGpuLoad
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.returnStatus(switchGpuLoad.checked, 'GpuLoad', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Температура и загрузка ГП в процентах ")
                }

                Label {
                    id: labelGpuLoad
                    color: "#ffffff"
                    text: qsTr("Загрузка ГП")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }

            RowLayout {
                id: rowGpuClocks
                anchors.left: parent.left
                anchors.top: rowGpuLoad.bottom
                anchors.topMargin: 5
                anchors.leftMargin: 5
                Switch {
                    id: switchGpuClocks
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.returnStatus(switchGpuClocks.checked, 'GpuClocks', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Рабочие частоты ядра и памяти ГП ")
                }

                Label {
                    id: labelGpuClocks
                    color: "#ffffff"
                    text: qsTr("Частоты ГП")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }

            RowLayout {
                id: rowGpuMem
                anchors.left: parent.left
                anchors.top: rowGpuClocks.bottom
                anchors.topMargin: 5
                anchors.leftMargin: 5
                Switch {
                    id: switchGpuMem
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.returnStatus(switchGpuMem.checked, 'GpuMem', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Заполнение видеопамяти в мегабайтах ")
                }

                Label {
                    id: labelGpuMem
                    color: "#ffffff"
                    text: qsTr("Заполнение памяти")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }
        }

        Rectangle {
            id: bgRAM
            y: 95
            width: 347
            height: 132
            color: "#1d2128"
            radius: 10
            anchors.left: bgCPU.right
            anchors.top: bgCPU.bottom
            anchors.leftMargin: 20
            anchors.topMargin: -134
            Label {
                id: labelRAM
                x: 8
                y: 8
                color: "#ffffff"
                text: qsTr("RAM")
                font.pointSize: 16
            }

            RowLayout {
                id: rowRamLoad
                x: 5
                y: 44
                Switch {
                    id: switchRamLoad
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.returnStatus(switchRamLoad.checked, 'RamLoad', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Заполнение ОЗУ с процентной шкалой ")
                }

                Label {
                    id: labelRamLoad
                    color: "#ffffff"
                    text: qsTr("Процентное заполнение")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }

            RowLayout {
                id: rowRamMem
                anchors.left: parent.left
                anchors.top: rowRamLoad.bottom
                anchors.leftMargin: 5
                anchors.topMargin: 5
                Switch {
                    id: switchRamMem
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.returnStatus(switchRamMem.checked, 'RamMem', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Заполнение ОЗУ в гигабайтах ")
                }

                Label {
                    id: labelRamMem
                    color: "#ffffff"
                    text: qsTr("Наглядное заполнение")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }
        }

        Rectangle {
            id: bgOther
            y: 247
            width: 347
            height: 169
            color: "#1d2128"
            radius: 10
            anchors.left: bgGPU.right
            anchors.top: bgCPU.bottom
            anchors.topMargin: 20
            anchors.leftMargin: 20
            Label {
                id: labelOther
                x: 8
                y: 8
                color: "#ffffff"
                text: qsTr("Прочее")
                font.pointSize: 16
            }

            RowLayout {
                id: rowUptime
                x: 5
                y: 44
                Switch {
                    id: switchUptime
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.returnStatus(switchUptime.checked, 'Uptime', 'ForDecency')
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Время с момента включения компьютера ")
                }

                Label {
                    id: labelUptime
                    color: "#ffffff"
                    text: qsTr("Время работы компьютера")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }

            RowLayout {
                id: rowDriveUsedSpace
                anchors.left: parent.left
                anchors.top: rowUptime.bottom
                anchors.topMargin: 5
                anchors.leftMargin: 5
                Switch {
                    id: switchDriveUsedSpace
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.getDriveComboBox()
                        backend.returnStatus(switchDriveUsedSpace.checked, 'DriveUsedSpace', 'ReduceTheAmount')
                        if (switchDriveUsedSpace.checked == true){
                            comboDriveUsedSpace.enabled = true
                        }
                        if (switchDriveUsedSpace.checked == false){
                            comboDriveUsedSpace.enabled = false
                        }
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Параметр разблокирует выбор дисков ")
                }

                Label {
                    id: labelDriveUsedSpace
                    color: "#ffffff"
                    text: qsTr("Занятое место на диске")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }

            RowLayout {
                id: rowDriveRate
                anchors.left: parent.left
                anchors.top: rowDriveUsedSpace.bottom
                anchors.leftMargin: 5
                anchors.topMargin: 5
                Switch {
                    id: switchDriveRate
                    text: ""
                    font.pointSize: 12
                    onToggled: {
                        backend.getDriveComboBox()
                        backend.returnStatus(switchDriveRate.checked, 'DriveRate', 'ReduceTheAmount')
                        if (switchDriveRate.checked == true){
                            comboDriveRate.enabled = true
                        }
                        if (switchDriveRate.checked == false){
                            comboDriveRate.enabled = false
                        }
                    }

                    ToolTip.delay: 500
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr(" Параметр разблокирует выбор дисков ")
                }

                Label {
                    id: labelDriveRate
                    color: "#ffffff"
                    text: qsTr("Скорость чтения/записи диска")
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredHeight: 22
                    font.pointSize: 14
                }
            }
        }

        Rectangle {
            id: bgDrives
            y: 285
            width: 200
            height: 130
            color: "#1d2128"
            radius: 10
            anchors.left: bgOther.right
            anchors.leftMargin: 20
            Label {
                id: labelDrives
                x: 8
                y: 8
                color: "#ffffff"
                text: qsTr("Drives")
                font.pointSize: 16
            }

            CustomCombobox {
                id: comboDriveUsedSpace
                font.pointSize: 12
                enabled: false
                y: 56
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: labelDrives.bottom
                anchors.leftMargin: 12
                anchors.rightMargin: 13
                anchors.topMargin: 15
                onActivated: {
                    backend.returnDiskStatus('Used Space ', comboDriveUsedSpace.currentText)
                }

                ToolTip.delay: 500
                ToolTip.visible: hovered
                ToolTip.text: qsTr(" Информация о занятом пространстве на диске ")
            }

            CustomCombobox {
                id: comboDriveRate
                font.pointSize: 12
                enabled: false
                y: 56
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: comboDriveUsedSpace.bottom
                anchors.leftMargin: 12
                anchors.topMargin: 9
                anchors.rightMargin: 13
                onActivated: {
                    backend.returnDiskStatus('Rate ', comboDriveRate.currentText)
                }

                ToolTip.delay: 500
                ToolTip.visible: hovered
                ToolTip.text: qsTr(" Информация о рабочей скорости записи и чтения диска ")
            }
        }

        Rectangle {
            id: bgPort
            x: 654
            y: 98
            width: 202
            height: 172
            color: "#1d2128"
            radius: 10
            anchors.bottom: bgDrives.top
            anchors.bottomMargin: 15

            Label {
                id: labelPorts
                x: 25
                y: 5
                color: "#ffffff"
                text: qsTr("Output settings")
                font.pointSize: 16
            }

            CustomTextField {
                id: textFrequency
                y: 50
                height: 27
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: comboPorts.top
                horizontalAlignment: Text.AlignLeft
                renderType: Text.QtRendering
                anchors.rightMargin: 23
                anchors.bottomMargin: 15
                antialiasing: true
                layer.smooth: false
                scale: 1.1
                anchors.verticalCenterOffset: 2
                anchors.leftMargin: 23
                placeholderText: qsTr("Интервал в секундах")
                validator: IntValidator {bottom: 0; top: 999999;}
                onEditingFinished: {
                    backend.getSettings(textFrequency.displayText)
                }
            }

            CustomCombobox {
                id: comboPorts
                width: 81
                height: 27
                anchors.bottom: btnApply.top
//                displayText: "Choose"
                anchors.bottomMargin: 15
                anchors.horizontalCenter: btnApply.horizontalCenter
                font.pointSize: 12
                onActivated: {
                    backend.getPortsComboBox()
                }
            }

            CustomButton {
                id: btnOpenPort
                width: 81
                height: 27
                text: "Open"
                anchors.verticalCenter: comboPorts.verticalCenter
                anchors.horizontalCenter: btnStop.horizontalCenter
                font.pointSize: 13
                Layout.maximumWidth: 200
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                Layout.preferredWidth: 250
                onClicked: {
                    backend.openPort(comboPorts.currentText)
                }

                ToolTip.delay: 500
                ToolTip.visible: hovered
                ToolTip.text: qsTr(" Открыть COM-порт для передачи данных на микроконтроллер ")
            }

            CustomButton {
                id: btnApply
                y: 136
                height: 27
                text: "Apply"
                anchors.left: parent.left
                anchors.right: btnStop.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 15
                anchors.rightMargin: 10
                anchors.bottomMargin: 15
                Layout.fillWidth: true
                font.pointSize: 13
                Layout.preferredWidth: 250
                Layout.preferredHeight: 40
                Layout.maximumWidth: 200
                onClicked: {
                    backend.applyButton()
                }

                ToolTip.delay: 500
                ToolTip.visible: hovered
                ToolTip.text: qsTr(" Начать отправку данных на микроконтроллер ")
            }

            CustomButton {
                id: btnStop
                x: 57
                y: 126
                width: 81
                height: 27
                text: "Stop"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 15
                anchors.bottomMargin: 15
                font.pointSize: 13
                Layout.fillWidth: true
                Layout.preferredWidth: 250
                Layout.preferredHeight: 40
                Layout.maximumWidth: 200
                onClicked: {
                    backend.stopButton()
                }
                ToolTip.delay: 500
                ToolTip.visible: hovered
                ToolTip.text: qsTr(" Приостановить отправку данных на микроконтроллер ")
            }
        }

        Connections{
            target: backend

            function onDriveModelList(DriveModelList){
                comboDriveUsedSpace.model = DriveModelList
                comboDriveRate.model = DriveModelList
            }

            function onPortsModelList(PortsModelList){
                comboPorts.model = PortsModelList
            }

            function onCountLimit(position){
                if (position == true){
                    if (switchCpuLoad.checked == false) {switchCpuLoad.checkable = false}
                    if (switchCpuClocks.checked == false) {switchCpuClocks.checkable = false}
                    if (switchGpuLoad.checked == false) {switchGpuLoad.checkable = false}
                    if (switchGpuClocks.checked == false) {switchGpuClocks.checkable = false}
                    if (switchGpuMem.checked == false) {switchGpuMem.checkable = false}
                    if (switchRamLoad.checked == false) {switchRamLoad.checkable = false}
                    if (switchRamMem.checked == false) {switchRamMem.checkable = false}
                    if (switchUptime.checked == false) {switchUptime.checkable = false}
                }
                else{
                    switchCpuLoad.checkable = true
                    switchCpuClocks.checkable = true
                    switchGpuLoad.checkable = true
                    switchGpuClocks.checkable = true
                    switchGpuMem.checkable = true
                    switchRamLoad.checkable = true
                    switchRamMem.checkable = true
                    switchUptime.checkable = true
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:500;width:900}D{i:3}D{i:2}D{i:5}D{i:7}D{i:8}D{i:6}D{i:10}
D{i:11}D{i:9}D{i:4}D{i:13}D{i:15}D{i:16}D{i:14}D{i:18}D{i:19}D{i:17}D{i:21}D{i:22}
D{i:20}D{i:12}D{i:24}D{i:26}D{i:27}D{i:25}D{i:29}D{i:30}D{i:28}D{i:23}D{i:32}D{i:34}
D{i:35}D{i:33}D{i:37}D{i:38}D{i:36}D{i:40}D{i:41}D{i:39}D{i:31}D{i:43}D{i:44}D{i:45}
D{i:42}D{i:47}D{i:48}D{i:50}D{i:51}D{i:52}D{i:53}D{i:46}D{i:54}D{i:1}
}
##^##*/
