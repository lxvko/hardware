import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import 'controls'

Window {
    id: mainWindow
    width: 1000
    height: 600
    visible: true

    color: "#00000000"
    maximumWidth: 1000
    minimumWidth: 1000
    minimumHeight: 600
    maximumHeight: 600
    title: qsTr("Hardware Monitor")

    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        id: bg
        color: "#2c313c"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                x: 0
                y: 0
                height: 60
                color: "#1c1d20"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    y: 8
                    height: 25
                    color: "#282c34"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#5f6a82"
                        text: qsTr("Мониторинг датчиков системы")
                        font.pointSize: 10
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                        anchors.topMargin: 0
                    }

                    Label {
                        id: lagelRightInfo
                        color: "#5f6a82"
                        text: qsTr("EETK 414-KC")
                        font.pointSize: 10
                        anchors.left: labelTopInfo.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 0
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                         }
                    }

                    Image {
                        id: icon
                        width: 22
                        height: 22
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/hardware_icon.svg"
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        color: "#c3cbdd"
                        text: qsTr("Hardware Monitor")
                        anchors.left: icon.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 10
                        anchors.leftMargin: 5
                    }
                }

                Row {
                    id: rowBtns
                    x: 952
                    width: 70
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        onClicked: mainWindow.showMinimized()
                    }

                    TopBarButton {
                        id: btnClose
                        btnColorClicked: "#ff003c"
                        btnIconSource: '../../images/svg_images/close_icon.svg'
                        onClicked: {
                            backend.stopButton()
                            mainWindow.close()
                        }
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.rightMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    PropertyAnimation{
                        id: animationMenu
                        target: leftMenu
                        property: 'width'
                        to: if(leftMenu.width == 70) return 200; else return 70
                        duration: 1000
                        easing.type: Easing.InOutQuint
                    }


                    Column {
                        id: columnMenus
                        anchors.fill: parent
                        anchors.bottomMargin: 90

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                // btnSettings.isActiveMenu = false
                                btnAbout.isActiveMenu = false
                                pagesHome.visible = true
                                // pagesSettings.visible = false
                                pagesAbout.visible = false

                            }
                        }

                        // LeftMenuBtn {
                        //     id: btnSettings
                        //     width: leftMenu.width
                        //     text: qsTr("Settings")
                        //     btnIconSource: "../../images/svg_images/settings_icon.svg"
                        //     onClicked: {
                        //         btnHome.isActiveMenu = false
                        //         btnSettings.isActiveMenu = true
                        //         btnAbout.isActiveMenu = false
                        //         pagesHome.visible = false
                        //         pagesSettings.visible = true
                        //         pagesAbout.visible = false
                        //     }
                        // }
                    }

                    LeftMenuBtn {
                        id: btnAbout
                        x: 0
                        y: 120
                        width: leftMenu.width
                        text: qsTr("About")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        btnIconSource: "../../images/svg_images/about_icon.svg"
                        onClicked: {
                            btnHome.isActiveMenu = false
                            // btnSettings.isActiveMenu = false
                            btnAbout.isActiveMenu = true
                            pagesHome.visible = false
                            // pagesSettings.visible = false
                            pagesAbout.visible = true
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#00000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    Loader {
                        id: pagesHome
                        anchors.fill: parent
                        source: Qt.resolvedUrl('pages/homePage.qml')
                        visible: true
                    }
                    // Loader {
                    //     id: pagesSettings
                    //     anchors.fill: parent
                    //     source: Qt.resolvedUrl('pages/settingsPage.qml')
                    //     visible: false
                    //     onLoaded: {
                    //         backend.loadSettings()
                    //     }
                    // }
                    Loader {
                        id: pagesAbout
                        anchors.fill: parent
                        source: Qt.resolvedUrl('pages/aboutPage.qml')
                        visible: false

                    }

                }

                Rectangle {
                    id: bottonBar
                    y: 498
                    color: "#282c34"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0

                    Label {
                        id: labelBottomInfo
                        color: "#5f6a82"
                        text: qsTr("https://github.com/lxvko/hardware")
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                    }
                }
            }
        }
    }
}
