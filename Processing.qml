import QtQuick 2.5

Rectangle {
    id: root
    signal next

    color: "darkgray"

    anchors.fill: parent

    Column {
        spacing: 20
        anchors.fill: parent
        anchors.margins: 50

        ScaleableText {
            text: "Ihr ward Hammer!"
            color: "white"
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Bitte warten, eure Bilder sind bald fertig."
            color: "white"
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Die Selbstmordzelle ist wieder für Euch da in:"
            color: "white"
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Text {
            text: timer.countdown + " s"
            color: "white"
            font.pixelSize: 300
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    Timer {
        id: timer
        property int countdown
        interval: 1000
        repeat: true
        onTriggered: {
            countdown--
            if (countdown == 0) {
                timer.stop()
                root.next()
            }
        }
    }

    // TODO: Remove - only for debugging
    Keys.onSpacePressed: {
        timer.stop()
        root.next()
    }

    function start() {
        timer.countdown = 60
        timer.start()
    }
}

