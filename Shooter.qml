import QtQuick 2.5

Rectangle {
    id: root

    signal next

    property int countdown: 3
    property int picsToTake: 4

    color: "black"
    anchors.fill: parent

    Text {
        id: countdownText
        color: "white"
        text: root.countdown
        font.pixelSize: 200
        anchors.centerIn: parent
    }

    Timer {
        id: timer
        running: false
        repeat: true
        interval: 1000
        onTriggered: {
            root.countdown--
            if (root.countdown === -1) {
                stop()
                takePicture()
            }
        }
    }

    function start() {
        root.countdown = 3
        root.picsToTake = 4
        countdownText.visible = true
        timer.start()
    }

    Timer {
        id: dummyPictureTimer
        interval: 2500
        repeat: false
        onTriggered: onPictureTaken()
    }

    function takePicture() {
        console.log("FIRE")
        countdownText.visible = false
        root.picsToTake--
        dummyPictureTimer.start()
    }

    function onPictureTaken() {

        if (root.picsToTake > 0) {
            root.countdown = 3
            timer.start()
            countdownText.visible = true
        } else {
            console.log("All pix taken")
            root.next()
        }


    }
}

