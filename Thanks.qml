import QtQuick 2.5

Rectangle {
    id: root
    signal next

    color: "black"

    anchors.fill: parent

    Column {
        anchors.fill: parent
        anchors.margins: 80

        ScaleableText {
            text: "WOW... Ihr seid super geil!"
            color: "#ff00aa"
            font.family: "Roboto"
            font.weight: Font.Thin
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Image {
            source: "supergeil1.jpg"
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Gleich geht es los!!!"
            color: "#ff00aa"
            font.family: "Roboto"
            font.weight: Font.Thin
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    Timer {
        id: timer
        interval: 5000
        onTriggered: next()
    }

    function start() {
        timer.start()
    }

}
