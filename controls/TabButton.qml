import QtQuick 2.0
import QtQuick.Controls 2.0

TabButton {
    id: control
    height: 80

    contentItem: Text {
        text: control.text
        font.pixelSize: 30
        color: control.checked ? "black" : "grey"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        anchors.fill: parent
        color: control.down ? (control.checked ? "whitesmoke" : "navajowhite") : (control.checked ? "white" : "moccasin")
        border.color: control.checked ? "blanchedalmond" : "powderblue"
        border.width: 1
        radius: 10
    }

}
