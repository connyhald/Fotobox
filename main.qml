import QtQuick 2.5
import QtQuick.Window 2.2
import QtMultimedia 5.5

Window {
    width: 1024
    height: 768

    visible: true

    InitialWaiting {
        id: initialWaiting
        focus: true
        onNext: {
            visible = false
            preview.visible = true
            preview.focus = true
            preview.start()
        }
    }

    Preview {
        id: preview
        visible: false
        onNext: {
            visible = false
            shooter.visible = true
            shooter.focus = true
            shooter.start()
        }
    }

    Shooter {
        id: shooter
        visible: false
        onNext: {
            visible = false
            processing.visible = true
            processing.focus = true
            processing.start()
        }
    }

    Processing {
        id: processing
        visible: false
        onNext: {
            visible = false
            initialWaiting.visible = true
            initialWaiting.focus = true
            initialWaiting.start()
        }
    }


    /*

    Rectangle {
        anchors.fill: parent

        Camera {
            id: camera
            captureMode: Camera.CaptureViewfinder
            //deviceId: "/dev/video0"

            imageCapture {
                id: capture


                onImageCaptured: {
                    // Show the preview in an Image
                    //photoPreview.source = preview
                }


                onCapturedImagePathChanged: console.log(capture.capturedImagePath)
                onImageSaved: console.log("Saved: " + path)
            }

        }

        VideoOutput {
            id: output
            source: camera
            anchors.fill: parent
            anchors.margins: 50
        }

        Rectangle {
            id: flash
            color: "white"
            opacity: 0
            anchors.fill: output

            Text {
                text: "BLITZ"
                font.pixelSize: 50
                anchors.centerIn: parent
            }

            SequentialAnimation {
                id: flashAnimation

                OpacityAnimator {
                    target: flash
                    to: 1
                    duration: 1000
                    easing.type: Easing.InQuad
                }

                OpacityAnimator {
                    target: flash
                    to: 0
                    duration: 1000
                    easing.type: Easing.OutQuad
                }
            }
        }

        Rectangle {
            color: "transparent"
            border.color: "green"
            border.width: 2
            anchors.fill: output
            anchors.margins: 50
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

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // camera.imageCapture.capture()
            camera.imageCapture.captureToLocation("/home/conny/tmp/out.jpg")
            flashAnimation.start()
        }
    }

    Component.onCompleted: {
        var cams = QtMultimedia.availableCameras
        for (var i = 0; i < cams.length; i++) {
            console.log(cams[i].deviceId)
        }

        //camera.deviceId = cams[0].deviceId

    }
    */
}
