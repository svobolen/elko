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

    statisticsButton.onClicked: {
        var i   = 0.1 * maxSpikes
        var ii  = 0.3 * maxSpikes
        var iii = 0.5 * maxSpikes
        var iv  = 0.7 * maxSpikes
        var v   = 0.9 * maxSpikes
        var gradientColor
        var currElec
        for (var m = 0; m < electrodeRep.count; m++) {
            currElec = electrodeRep.itemAt(m).elec.basicE
            for (var k = 0; k < currElec.rowCount; k++) {
                for (var l = 0; l < currElec.columnCount; l++) {
                    if(currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes !== 0) {
                        console.log("show spikes " + currElec.rowRep.itemAt(k).colRep.itemAt(l).trackName
                                    + " " + currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes)

                        if (currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes < i) {
                            gradientColor = "indigo"
                        } else if (currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes < ii) {
                            gradientColor = "blue"
                        } else if (currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes < iii) {
                            gradientColor = "green"
                        } else if (currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes < iv) {
                            gradientColor = "yellow"
                        } else if (currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes < v) {
                            gradientColor = "orange"
                        } else if (currElec.rowRep.itemAt(k).colRep.itemAt(l).spikes > v) {
                            gradientColor = "red"
                        }
                        currElec.rowRep.itemAt(k).colRep.itemAt(l).colorFill = gradientColor
                    }
                }
            }
        }
    }

    comboBox.onCurrentIndexChanged: {
        changeNames(comboBox.currentIndex)
    }

    zoomSwitch.onCheckedChanged: {
        zoomEnabled = zoomSwitch.checked
    }

    fixButton.onCheckedChanged: {
        for (var i = 0; i < electrodeRep.count; i++) {
            var electrodeI = electrodeRep.itemAt(i).elec

            electrodeI.draggable = !fixButton.checked
            electrodeI.mouseArea.drag.target =
                    (fixButton.checked) ? null : electrodeI.basicE
            for (var j = 0; j < electrodeI.children.length; j++) {
                if(electrodeI.children[j].columnCount != null) {
                    electrodeI.children[j].draggable = !fixButton.checked
                    electrodeI.children[j].mouseArea.drag.target =
                            (fixButton.checked) ? null : electrodeI.children[j].basicE
                }
            }
        }
    }

    function changeNames(comboBoxValue) {
        for (var i = 0; i < electrodeRep.count; i++) {
            var currElec = electrodeRep.itemAt(i).elec.basicE
            for (var k = 0; k < currElec.rowCount; k++) {
                for (var l = 0; l < currElec.columnCount; l++) {
                    switch (comboBoxValue) {
                    case 0: // only default name
                        currElec.rowRep.itemAt(k).colRep.itemAt(l).name = currElec.rowRep.itemAt(k).colRep.itemAt(l).defaultName;
                        break;
                    case 1: // only wave names (non-linked are empty)
                        currElec.rowRep.itemAt(k).colRep.itemAt(l).name = currElec.rowRep.itemAt(k).colRep.itemAt(l).trackName
                        break;
                    default: // wave names, non-linked default name
                        currElec.rowRep.itemAt(k).colRep.itemAt(l).name =
                                (currElec.rowRep.itemAt(k).colRep.itemAt(l).trackName === "") ?
                                    currElec.rowRep.itemAt(k).colRep.itemAt(l).defaultName : currElec.rowRep.itemAt(k).colRep.itemAt(l).trackName
                        break;
                    }
                }
            }
        }
    }
}
