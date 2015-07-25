import QtQuick 2.5

Rectangle {
    id: root
    signal next

    color: "darkgray"

    anchors.fill: parent

    Text {
        id: text
        text: "Bitte Geld einwerfen"
        font.pixelSize: 50
        color: "white"
        anchors.centerIn: parent
    }

    Keys.onSpacePressed: {
        onMoneyAccepted()
    }

    Keys.onReturnPressed: {
        backend.createFinalImageAndPrint()
    }

    Timer {
        id: timer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            console.log("next")
            root.next()
        }
    }

    Rectangle {
        id: rect
        width: 200
        height: 200
        color: "pink"
        anchors.centerIn: parent

        PropertyAnimation {
            target: rect
            running: true
            loops: Animation.Infinite
            property: "rotation"
            duration: 1000
            from: 0
            to: 359
        }
    }

    function start() {
        text.text = "Bitte Geld einwerfen"
    }

    // TODO: Meldung passend to Geldeinfwurf. Video vom Supergeili
    function onMoneyAccepted() {
        console.log("POW WOW FIREWORK")
        text.text = "Wow, Danke, 2€, ihr seid so geil !!!"
        timer.start()
    }

}

