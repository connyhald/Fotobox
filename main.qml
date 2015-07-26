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
            opacity = 0
            thanks.opacity = 1
            thanks.focus = true
            thanks.start()
        }
        Behavior on opacity { OpacityAnimator { duration: 1000} }
    }

    Thanks {
        id: thanks
        opacity: 0
        onNext: {
            opacity = 0
            previewAndShoot.opacity = 1
            previewAndShoot.focus = true
            previewAndShoot.start()
        }
        Behavior on opacity { OpacityAnimator { duration: 1000} }
    }

    Preview {
        id: previewAndShoot
        opacity: 0
        onNext: {
            opacity = 0
            processing.opacity = 1
            processing.focus = true
            processing.start()
        }
        Behavior on opacity { OpacityAnimator { duration: 1000} }
    }

    Processing {
        id: processing
        opacity: 0
        onNext: {
            opacity = 0
            initialWaiting.opacity = 1
            initialWaiting.focus = true
            initialWaiting.start()
        }
        Behavior on opacity { OpacityAnimator { duration: 1000} }
    }
}
