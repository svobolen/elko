import QtQuick 2.7
import QtQuick.Controls 2.0


ImageManagerForm {

    confirmButton.onClicked: {
        var checkedImages = getCheckedImages()
        console.log("User chose " + checkedImages.length + " image(s): " + checkedImages.toString())
        window.images = checkedImages
        window.changePage("Electrode Manager", "qrc:/pages/ElectrodeManager.qml", 1)
    }

    resetButton.onClicked: resetChoice()

    function resetChoice() {
        for (var k = 0; k < swipe.count; k++) {
            for (var i = 0; i < swipe.itemAt(k).images.count; i++) {
                swipe.itemAt(k).images.itemAt(i).imgChecked = false
            }
        }
    }

    function getCheckedImages() {
        var sourceArray = []
        for (var k = 0; k < swipe.count; k++) {
            for (var i = 0; i < swipe.itemAt(k).images.count; i++) {
                if (swipe.itemAt(k).images.itemAt(i).imgChecked) {
                    sourceArray.push(swipe.itemAt(k).images.itemAt(i).sourceImg)
                }
            }
        }
        return sourceArray
    }
}
