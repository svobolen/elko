import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Pane {
    id: imageManager
    property var name
    property var images

    property alias swipe: swipe
    property alias resetButton: resetButton
    property alias confirmButton: confirmButton

    ListModel {
        id: brains
        ListElement { sourcePath: "qrc:/images/brains/brain1.png"}
        ListElement { sourcePath: "qrc:/images/brains/brain3.png"}
        ListElement { sourcePath: "qrc:/images/brains/brain4.png"}
        ListElement { sourcePath: "qrc:/images/brains/brain2.jpg"}
    }
    ListModel {
        id: pluses
        ListElement { sourcePath: "qrc:/images/plus.png"}
        ListElement { sourcePath: "qrc:/images/plus.png"}
        ListElement { sourcePath: "qrc:/images/plus.png"}
        ListElement { sourcePath: "qrc:/images/plus.png"}
    }

    SwipeView {
        id: swipe
        currentIndex: 0
        anchors {fill: parent; bottom: indicator.top}

        Component.onCompleted: {
            swipe.addItem(newPage.createObject(swipe, {"imageModel": brains}))
        }
    }
    Component {
        id: newPage

        Pane {
            id: secondPage
            property alias images: rep
            property ListModel imageModel
            width: swipe.width
            height: swipe.height


            PinchArea {
                anchors.fill: parent
                pinch.target: secondPage
                pinch.minimumScale: 1
                pinch.maximumScale: 10
                pinch.dragAxis: Pinch.XAndYAxis
                onSmartZoom: { secondPage.scale = pinch.scale }
                onPinchFinished: {
                    secondPage.scale = 1
                    secondPage.x = 0
                    secondPage.y = 0
                }
            }
            Label {
                id: label
                text: qsTr("Choose one or more images. You can upload your own photos or pictures.")
                font {pixelSize: 13; italic: true}
                width: parent.width
                z: 2
                anchors {margins: 5; left: parent.left; right: parent.right}
                horizontalAlignment: Qt.AlignHCenter
                wrapMode: Label.Wrap
            }
            Grid {
                id: imageGrid
                columns: 2
                rows: 2
                spacing: 10
                width: parent.width
                height: parent.height

                Repeater {
                    id: rep
                    model: imageModel
                    Brain {
                        sourceImg: model.sourcePath
                        checkboxVisible: (model.sourcePath === "qrc:/images/plus.png") ? false : true
                    }
                }
            }
            Button {
                id: addButton
                text: "+"
                font.pixelSize: 21
                width: height
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    swipe.insertItem(swipe.currentIndex + 1, newPage.createObject(swipe, {"imageModel": pluses}))
                    swipe.currentIndex++
                    console.log("Page number " + swipe.currentIndex + " was added to swipe. (Counting from zero.)")
                }
            }
            Button {
                id: deleteButton
                text: "-"
                font.pixelSize: 21
                width: height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    if(swipe.count < 1 || swipe.currentIndex === 0) {
                        deleteButton.enabled = false
                        console.log("There have to be at least 1 page in swipe./First page cannot be deleted.")
                    } else {
                        console.log("Page " + swipe.currentIndex + " was removed from swipe. (Counting from zero.)")
                        swipe.removeItem(swipe.currentIndex)
                    }
                }
            }
        }
    }

    Button {
        id: confirmButton
        text: qsTr("OK")
        x: parent.width / 2 - (width + anchors.margins + resetButton.width) / 2
        anchors {margins: 10; bottomMargin: 50 }
        anchors {bottom: indicator.top; right: resetButton.left}

    }
    Button {
        id: resetButton
        text: qsTr("Reset")
        anchors {margins: 10; bottomMargin: 50 }
        anchors {bottom: indicator.top; left: confirmButton.right}

    }
    PageIndicator {
        id: indicator
        count: swipe.count
        currentIndex: swipe.currentIndex
        anchors {bottom: parent.bottom; horizontalCenter: parent.horizontalCenter}
    }
}
