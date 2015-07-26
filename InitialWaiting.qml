import QtQuick 2.5

Rectangle {
    id: root
    signal next

    color: "darkgray"

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
        anchors.margins: 50

        ScaleableText {
            id: txt
            color: "#ff00aa"
            text: "Hallo Ihr Hübschen!"
            font.family: "Roboto"
            font.weight: Font.Thin
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Werft bitte eine Münze zwischen 50ct und 2€ ein!"
            color: "white"
            font.family: "Roboto"
            font.weight: Font.Normal
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Das ist eine Spende an das Brautpaar, also seid großzügig :-)"
            color: "#ff00aa"
            font.family: "Roboto"
            font.weight: Font.Normal
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScaleableText {
            text: "Los geht's!"
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

    Keys.onReturnPressed: {
        backend.createFinalImageAndPrint(["1","2","3","4"])
    }

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

    function start() {
        // Start animation or stuff
    }

    // TODO: Meldung passend to Geldeinfwurf. Video vom Supergeili
    function onMoneyAccepted() {
        next();
    }

}

