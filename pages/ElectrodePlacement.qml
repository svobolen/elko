import QtQuick 2.7

ElectrodePlacementForm {

    exportButton.onClicked: {
        fileDialog.open()
    }

    fileDialog.onAccepted: {
        var filePath = ( fileDialog.fileUrl + "").replace('file:///', '');
        electrodePlacement.grabToImage(function(result) {
            if (!result.saveToFile(filePath)){
                console.error('Unknown error saving to ',filePath);
            }
        });
        console.log("Screenshot has been saved to " + filePath)
    }

    fileDialog.onRejected: {
        console.log("Saving file canceled.")
    }

    resetButton.onClicked: {
        stackView.replace("qrc:/pages/ElectrodePlacement.qml", {"electrodes": electrodes, "images": window.images,"name": "Electrode Placement"} )
    }

    comboBox.onCurrentIndexChanged: {
        for (var i = 0; i < electrodeRep.count; i++) {
            electrodeRep.itemAt(i).elec.basicE.changeNames(comboBox.currentIndex)
        }
    }

    zoomSwitch.onCheckedChanged: {
        zoomEnabled = zoomSwitch.checked
    }

    fixButton.onCheckedChanged: {
        for (var i = 0; i < electrodeRep.count; i++) {
            electrodeRep.itemAt(i).elec.draggable = !fixButton.checked
            electrodeRep.itemAt(i).elec.mouseArea.drag.target =
                    (fixButton.checked) ? null : electrodeRep.itemAt(i).elec.basicE
        }
    }
}
