import QtQuick 2.5

Rectangle {
    id: root
    signal next

    color: "gray"

    anchors.fill: parent

    Text {
        text: "Supi!\nBilder werden belichtet.\nBitte warten... (druckt bald)"
        color: "white"
        font.pixelSize: 50
        horizontalAlignment: Text.Center
        anchors.centerIn: parent
    }

    // TODO: Later replace with a timer of about 1 minute
    Keys.onSpacePressed: root.next()

    function start() {
    }
}

