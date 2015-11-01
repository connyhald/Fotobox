import QtQuick 2.5

/*
  Text element that scales its text to fill the whole given width.
*/
Item {
    property alias text: txt.text
    property alias font: txt.font
    property alias color: txt.color

    height: txt.implicitHeight * txt.scale

    Text {
        id: txt
        transformOrigin: Item.TopLeft
        scale: parent.width / paintedWidth
        font.family: "Roboto"
        font.weight: Font.Light
    }
}

