import QtQuick 2.7
import QtQuick.XmlListModel 2.0

Item {
    property alias trackModel: trackModel
    property string sourcePath: "qrc:/xmls/sample.gdf.mont"

    XmlListModel {
        id: trackModel
        source: sourcePath
        query: "/document/montageTable/montage/trackTable/track"

        XmlRole { name: "label"; query: "@label/string()" }
//        XmlRole { name: "code"; query: "code/string()" }
    }

}
