import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2


ApplicationWindow {
    id: window
    width: 1020
    height: 660
    visible: true
    title: "Elko"
    property var images

    header: ToolBar {

        background: Rectangle {
            implicitHeight: 40
            color: "skyblue"
            opacity: 0.3
        }

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/drawer.png"
                }
                onClicked: drawer.open()
            }

            Label {
                id: titleLabel
                text: "Elko"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: qsTr("Save session...")
                        onTriggered: saveDialog.open()
                    }
                    MenuItem {
                        text: qsTr("Open session...")
                        onTriggered: openDialog.open()
                    }
                    MenuItem {
                        text: qsTr("About")
                        onTriggered: aboutDialog.open()
                    }
                    MenuItem {
                        text: qsTr("Exit")
                        onTriggered: Qt.quit()
                    }
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 1.5
        height: window.height

        background: Rectangle {
            Rectangle {
                x: parent.width - 1
                width: 1
                height: parent.height
                color: "skyblue"
            }
        }

        ListView {
            id: listView
            currentIndex: -1
            anchors.fill: parent


            delegate: ItemDelegate {
                id: control
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: control.down ? 0.3 : 1
                    color: control.down ? "skyblue" : "white"
                }

                onClicked: {
                    changePage(model.title, model.source, index)
                    drawer.close()
                }
            }
            model: pageModel
            ScrollIndicator.vertical: ScrollIndicator { }

            ListModel {
                id: pageModel
                ListElement { title: "Image Manager"; source: "qrc:/pages/ImageManager.qml" }
                ListElement { title: "Electrode Manager"; source: "qrc:/pages/ElectrodeManager.qml" }
                ListElement { title: "Link Signal with Electrode"; source: "qrc:/pages/ElectrodeSignalLink.qml"}
                ListElement { title: "Electrode Placement"; source: "qrc:/pages/ElectrodePlacement.qml" }
            }
        }


    }

    StackView {     //inicializace stacku, uvodni stranka
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane
            property string name: "Welcome page"
            Image {
                source: "qrc:/images/Doctor_Hibbert.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.centerIn: parent;
            }
            PinchArea {
                anchors.fill: parent
                pinch.target: pane
                pinch.minimumScale: 1
                pinch.maximumScale: 10
                pinch.dragAxis: Pinch.XAndYAxis
                onSmartZoom: pane.scale = pinch.scale
                onPinchFinished: {
                    pane.scale = 1
                    pane.x = 0
                    pane.y = 0
                }
            }
        }
        replaceEnter: Transition {
            XAnimator {
                duration: 0
            }
        }
    }

    Popup {
        id: aboutDialog
        modal: true
        focus: true
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3
        height: aboutColumn.implicitHeight + topPadding + bottomPadding

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                text: qsTr("About")
                font.bold: true
            }
            Label {
                width: aboutDialog.availableWidth
                text: "Author:    Lenka Svobodová "
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
            Label {
                width: aboutDialog.availableWidth
                text: "E-mail:    svobole5@fel.cvut.cz "
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
            Label {
                width: aboutDialog.availableWidth
                text: "Year:      2017"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
            Button {
                id: okButton
                text: "Ok"
                onClicked: aboutDialog.close()
            }
        }
    }

    FileDialog {
        id: saveDialog
        folder: shortcuts.documents
        selectExisting: false
        nameFilters: [ "All files (*)" ]
        onAccepted: {

        }
        onRejected: console.log("Saving file canceled.")
    }

    FileDialog {
        id: openDialog
        nameFilters: [ "", "All files (*)" ]
        folder: shortcuts.documents
        onAccepted: {
            //            var path = fileDialog.fileUrl
            //            if (fileDialog.checkIfImage(path.toString())) {
            //                fileDialog.addImage(path)
            //            } else {
            //                console.log("Chosen file is not an image.")
            //                info.open()
            //            }
        }
        onRejected: console.log("Choosing file canceled.")
    }

    function changePage(title, source, index) {
        if (listView.currentIndex !== index) {
            listView.currentIndex = index
            titleLabel.text = title

            var stackItem = stackView.find(function(item, index) {
                return item.name === title })

            if (stackItem === null) {
                stackView.push(source, {"name": title})
            } else {
                stackView.push(stackItem)
            }
        }
    }
}
