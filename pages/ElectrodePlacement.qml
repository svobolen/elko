import QtQuick 2.7

ElectrodePlacementForm {

    zoomSwitch.onCheckedChanged: { zoomEnabled = zoomSwitch.checked }
    fixButton.onCheckedChanged: { setDraggable(!zoomSwitch.checked) }
    comboBox.onCurrentIndexChanged: {
        for (var i = 0; i < elecList.count; i++) {
            elecList.currentIndex = i
            elecList.currentItem.elec.basicE.changeNames(currentIndex)
        }
        elecList.currentIndex = 0
    }
    exportButton.onClicked: { fileDialog.open() }
    fileDialog.onAccepted: {
        var filePath = ( fileDialog.fileUrl + "").replace('file:///', '');
        electrodePlacement.grabToImage(function(result) {
            if (!result.saveToFile(filePath)){
                console.error('Unknown error saving to ',filePath);
            }
        });
        console.log("Screenshot has been saved to " + filePath)
    }
    fileDialog.onRejected: { console.log("Saving file canceled.") }

    function setDraggable(boolDrag) {
        for (var i = 0; i < elecList.count; i++) {
            elecList.currentIndex = i
            elecList.currentItem.elec.draggable = boolDrag
            elecList.currentItem.elec.mouseArea.drag.target = null
        }
    }
}
