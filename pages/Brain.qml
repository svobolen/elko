import QtQuick 2.7
import QtQuick.Dialogs 1.2


BrainForm {

    mouseArea.onClicked: {
        if (brainImage.source == plusImgSource) {
            loader.sourceComponent = fileComp
        } else {
            checkbox.checked = !checkbox.checked
        }
    }

    mouseArea.onPressAndHold: {
        menu.open()
    }

    changeMenu.onTriggered: {
        loader.sourceComponent = fileComp
    }

    deleteMenu.onTriggered: {
        brainImage.source = plusImgSource;
        checkbox.visible = false
        checkbox.checked = false
        console.log("Image has been deleted.")
    }

    checkbox.onCheckStateChanged:  {
        brainImage.opacity = checkbox.checked ? 0.5 : 1
    }

    function checkIfImage(source) {
        var fileExtension = source.substring(source.length-4,source.length).toLowerCase()
        return ( (fileExtension === (".jpg")) || (fileExtension === ".png") || (fileExtension === ".bmp"))
    }

    function addImage(source) {
        brainImage.source = source
        sourceImg = source
        checkbox.visible = true
        checkbox.checked = false
        console.log("You chose: " + source)
    }

    Component {
        id: fileComp
        FileDialog {
            id: fileDialog
            nameFilters: [ "Image files (*.jpg *.png *.bmp)", "All files (*)" ]
            folder: shortcuts.pictures
            onAccepted: {
                var path = fileDialog.fileUrl
                if (checkIfImage(path.toString())) {
                    addImage(path)
                } else {
                    console.log("Chosen file is not an image.")
                    info.open()
                }
                loader.sourceComponent = undefined
            }
            onRejected: {
                loader.sourceComponent = undefined
                console.log("Choosing file canceled.")
            }
            Component.onCompleted: open()
        }
    }

    Loader {id: loader }
}
