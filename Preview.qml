import QtQuick 2.5

Item {
    id: root

    signal next

    property int countdown: 10

    anchors.fill: parent


    Rectangle {
        border.width: 2
        border.color: "green"
        anchors.fill: parent
        anchors.margins: 50
    }

    Rectangle {
        id: black
        visible: false
        color: "black"
        anchors.fill: parent
    }

    Text {
        id: countdownText
        text: root.countdown
        font.pixelSize: 50
        anchors.centerIn: parent
    }

    Timer {
        id: timer
        running: false
        interval: 1000
        repeat: true
        onTriggered: {
            root.countdown--
            if (root.countdown == 3) {
                stop()
                root.next()
                //black.visible = true
                //countdownText.color = "white"
            }

        }
    }

    function start() {
        root.countdown = 10
        timer.start()
    }



}

