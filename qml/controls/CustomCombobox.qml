import QtQuick
import QtQuick.Controls

ComboBox {
    id: control
    model: ["Choose"]

    delegate: ItemDelegate {
        background: Rectangle {
            radius: 15
            color: "#282c34"
        }

        width: control.width
        contentItem: Text {
            text: modelData
            color: "#81848c"
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8

        contextType: "2d"

        Connections {
            target: control
            function onPressedChanged() {
                canvas.requestPaint()
            }
        }

        onPaint: {
            context.reset()
            context.moveTo(0, 0)
            context.lineTo(width, 0)
            context.lineTo(width / 2, height)
            context.closePath()
            context.fillStyle = control.pressed ? "#81848c" : "#81848c"
            context.fill()
        }
    }

    contentItem: Text {
        color: "#81848c"

        text: control.displayText
        font: control.font
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHLeft
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        color: "#282c34"
        radius: 15
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            color: "#282c34"
            border.color: "#a09cac"
            border.width: 0
            radius: 15
        }
    }
}

/*##^##
Designer {
    D{i:0;height:50;width:200}
}
##^##*/

