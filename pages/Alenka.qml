import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    Button {
        id: button
        text: "Run Alenka"
        onClicked: starter.run("C:/Users/Lenka/Desktop/Alenka-Windows/Alenka.exe")
    }
}
