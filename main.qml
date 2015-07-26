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
            previewAndShoot.visible = true
            previewAndShoot.focus = true
            previewAndShoot.start()
        }
    }

    Preview {
        id: previewAndShoot
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
}
