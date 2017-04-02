import QtQuick 2.4

BrainForm {

    mouseArea.onClicked: {
        if (brainImage.source == plusImgSource) {
            fileDialog.open()
        } else {
            checkbox.checked = !checkbox.checked
        }
    }


    mouseArea.onPressAndHold: {
        menu.open()
    }

    changeMenu.onTriggered: {
        fileDialog.open()
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
    fileDialog.onAccepted: {
        var path = fileDialog.fileUrl
        if (checkIfImage(path.toString())) {
            addImage(path)
        } else {
            console.log("Chosen file is not an image.")
            info.open()
        }
    }

    fileDialog.onRejected: {
        console.log("Choosing file canceled.")
    }

    function checkIfImage(source) {
        var fileExtension = source.substring(source.length-4,source.length).toLowerCase()
        return ( (fileExtension === (".jpg")) || (fileExtension === ".png") )
    }
    function addImage(source) {
        brainImage.source = source
        sourceImg = source
        checkbox.visible = true
        checkbox.checked = false
        console.log("You chose: " + source)
    }

}
