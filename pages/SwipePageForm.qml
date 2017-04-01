import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Pane {
    id: firstPage
    property alias images: rep
    property alias addButton: addButton
    property alias deleteButton: deleteButton
    property alias resetButton: resetButton
    property alias confirmButton: confirmButton
    property alias picPinch: picPinch
    width: swipe.width
    height: swipe.height

    PinchArea {
        id: picPinch
        anchors.fill: parent
        pinch.target: firstPage
        pinch.minimumScale: 1
        pinch.maximumScale: 10
        pinch.dragAxis: Pinch.XAndYAxis
        onSmartZoom: { firstPage.scale = pinch.scale }
        onPinchFinished: {
            firstPage.scale = 1
            firstPage.x = 0
            firstPage.y = 0
        }
    }
    Label {
        id: label
        text: qsTr("Choose one or more images. You can upload your own photos or pictures.")
        z: 2
        font {pixelSize: 13; italic: true}
        width: parent.width
        anchors {margins: 5; left: parent.left; right: parent.right}
        horizontalAlignment: Qt.AlignHCenter
        wrapMode: Label.Wrap
    }
    Grid {
        id: grid
        columns: 2
        rows: 2
        spacing: 10
        width: parent.width
        height: parent.height

        ListModel {
            id: imageModel
            ListElement { sourcePath: "qrc:/images/plus.png"}
            ListElement { sourcePath: "qrc:/images/plus.png"}
            ListElement { sourcePath: "qrc:/images/plus.png"}
            ListElement { sourcePath: "qrc:/images/plus.png"}
        }

        ListModel {
            id: brainModel
            ListElement { sourcePath: "qrc:/images/brains/brain1.png"}
            ListElement { sourcePath: "qrc:/images/brains/brain3.png"}
            ListElement { sourcePath: "qrc:/images/brains/brain4.png"}
            ListElement { sourcePath: "qrc:/images/brains/brain2.jpg"}
        }

        Repeater {
            id: rep
            model: brainModel
            Brain {
                sourceImg: model.sourcePath
                //checkboxVisible: true
            }
        }
    }
    Button {
        id: confirmButton
        text: qsTr("OK")
        x: window.width / 2 - (width + anchors.margins + resetButton.width) / 2
        anchors {margins: 10; bottomMargin: 50 }
        anchors {bottom: parent.bottom; right: resetButton.left}
    }
    Button {
        id: resetButton
        text: qsTr("Reset")
        anchors {margins: 10; bottomMargin: 50 }
        anchors {bottom: parent.bottom; left: confirmButton.right}
    }
    Button {
        id: addButton
        text: "+"
        font.pixelSize: 21
        width: height
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

    }
    Button {
        id: deleteButton
        text: "-"
        font.pixelSize: 21
        width: height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
}
