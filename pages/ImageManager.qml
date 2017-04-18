import QtQuick 2.7
import QtQuick.Controls 2.0



ImageManagerForm {

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

    function confirm() {
        console.log("image manager")
        var checkedImages = getCheckedImages()
        console.log("User chose " + checkedImages.length + " image(s): " + checkedImages.toString())
        window.images = checkedImages
        window.changePage("Electrode Manager", "qrc:/pages/ElectrodeManager.qml", 1)
    }
}
