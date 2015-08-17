import QtQuick 2.5

Rectangle {
    id: root
    signal next

    property bool active: false

    color: "black"

    anchors.fill: parent

    Column {
        spacing: 20

        /*
        populate: Transition {
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.InOutQuad
                duration: 2000
            }
        }
        */

        anchors.fill: parent
        anchors.margins: 80

        ScaleableText {
            id: txt
            color: "#ff00aa"
            text: "Lustiges Partybild &"
            font.family: "Roboto"
            font.weight: Font.Thin
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Spende für das Brautpaar!"
            color: "white"
            font.family: "Roboto"
            font.weight: Font.Normal
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "50ct bis 2€ einwerfen!"
            color: "#ff00aa"
            font.family: "Roboto"
            font.weight: Font.Normal
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Bitte lächeln :-)"
            color: "white"
            font.family: "Roboto"
            font.weight: Font.Normal
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    Keys.onSpacePressed: {
        onMoneyAccepted()
    }

    Connections {
        target: backend
        onCoinAccepted: onMoneyAccepted()
    }

    // TODO: Just for debugging
    /*
    Timer {
        id: debugTimer
        running: true
        interval: 5000
        onTriggered: onMoneyAccepted()
    }
    */

    /*
    Keys.onReturnPressed: {
        backend.createFinalImageAndPrint(["1","2","3","4"])
    }
    */

    /*
    Timer {
        id: timer
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            console.log("next")
            root.next()
        }
    }
    */

    function start() {
        // Start animation or stuff
        //debugTimer.start()
        root.active = true
    }

    // TODO: Meldung passend to Geldeinfwurf. Video vom Supergeili
    function onMoneyAccepted() {
        if (root.active) {
            next()
            root.active = false
        } else {
            console.log("Monkey accepted, but not reacting since we are not active")
        }
    }

}

