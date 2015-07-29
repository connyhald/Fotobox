TEMPLATE = app

QT += qml quick printsupport

SOURCES += main.cpp \
    app.cpp \
    worker.cpp \
    gpiomanager.cpp

RESOURCES += qml.qrc

LIBS += -lwiringPi

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    TODO

HEADERS += \
    app.h \
    worker.h \
    gpiomanager.h
