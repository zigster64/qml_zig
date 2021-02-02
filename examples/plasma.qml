import QtQuick 2.2
import QtQuick.Controls 1.4

// If you have KDE installed, this should be available
import org.kde.plasma.core 2.0 as PlasmaCore

ApplicationWindow {
    id: window
    title: "Main Window"
    width: 600; height: 400
    color: "green"
    Component.onCompleted: visible = true

    Text {
        text: "Hit the Button\nfor Great Plasma"
        y: 30
        anchors.horizontalCenter: app.contentItem.horizontalCenter
        font.pointSize: 24; font.bold: true
    }

    Button {
        text: "Show me the Plasma"
        onClicked: plasma_dialog.show();
    }

    Item {
        PlasmaCore.Dialog {
            id: plasma_dialog
            title: "Plasma Dialog"
            visible: false
            mainItem: Item {
                width: 500
                height: 500

                Text {
                    anchors.centerIn: parent
                    color: "red"
                    text: qsTr("text")
                }

                Button {
                    text: "OK"
                    onClicked: window.close();
                }
            }
        }
    }
}
