import QtQuick 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    id: window
    title: "Main Window"
    width: 600; height: 400
    color: "green"
    Component.onCompleted: visible = true

    Text {
        text: "This should be styled\nwith the Flat setting"
        y: 30
        font.pointSize: 16; font.bold: true
    }

    Button {
        text: "Get me out of here"
        onClicked: window.close();
    }
}
