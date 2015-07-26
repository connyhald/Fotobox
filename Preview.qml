import QtQuick 2.5
import QtMultimedia 5.4
import QtGraphicalEffects 1.0

Item {
    id: root

    signal next

    property int countdown: 10
    property int picsToTake: 4
    property var imagePaths: []

    anchors.fill: parent

    Component.onCompleted: {
        var cams = QtMultimedia.availableCameras
        for (var i = 0; i < cams.length; i++) {
            console.log(cams[i].deviceId)
        }
        // Setting the device seems not to work with gphoto2
        //camera.deviceId = cams[0].deviceId
    }

    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage

        // We manually set the exif orientation, because some web cams (like the one
        // on the Dell XPS13 do not set a proper orientation and Qt 5.5.0 struggles to
        // load those files from disk. This will be fixed in Qt 5.5.1. See https://codereview.qt-project.org/#/c/115348/
        metaData.orientation: 0

        imageCapture {
            id: capture

            onImageSaved: {
                console.log("Saved: " + path)
                root.imagePaths.push(path)
                root.onPictureTaken()
            }
        }
    }

    // We scale it full screen. Not super precise, but looks better then with black bars
    VideoOutput {
        id: output
        source: camera
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }

    Rectangle {
        id: shade
        opacity: 0
        color: "black"
        anchors.fill: output

        OpacityAnimator {
            id: shadeAnim
            target: shade
            to: 1
            duration: 2000
        }
    }

    Item {
        id: countdownItem
        opacity: 0.5
        anchors.centerIn: parent

        Text {
            id: countdownText
            visible: false
            scale: 0.5
            layer.mipmap: true
            text: root.countdown
            font.pixelSize: 400
            font.bold: true
            color: "white"
            anchors.centerIn: parent
        }

        DropShadow {
            color: "black"
            fast: true
            radius: 32
            samples: 32
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
            spread: 0.5
            source: countdownText
            anchors.fill: countdownText
        }

        ParallelAnimation {
            id: countdownAnim
            ScaleAnimator {
                target: countdownItem
                to: 1
                duration: 9000
            }
            OpacityAnimator {
                target: countdownItem
                to: 1
                duration: 9000
            }
        }
    }

    Timer {
        id: timer
        running: false
        interval: 1000
        repeat: true
        onTriggered: {
            root.countdown--

            if (root.countdown == 4) {
                shadeAnim.start()
            }

            if (root.countdown == 0) {
                takePicture()
                timer.stop()
                countdownItem.visible = false
            }
        }
    }

    function start() {
        root.countdown = 10
        timer.start()
        countdownAnim.start()
    }

    function takePicture() {
        console.log("FIRE")
        root.picsToTake--
        camera.imageCapture.capture()
    }

    function onPictureTaken() {
        if (root.picsToTake > 0) {
            root.countdown = 3
            countdownItem.visible = true
            timer.start()
        } else {
            console.log(root.imagePaths)
            backend.createFinalImageAndPrint(root.imagePaths)
            root.next();
        }
    }
}

