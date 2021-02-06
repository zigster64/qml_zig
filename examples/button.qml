import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

ApplicationWindow {
    width: 400
    height: 400
    visible: true

    GroupBox {
        id: gridBox
        title: "Grid layout"
        Layout.fillWidth: true

        GridLayout {
            id: gridLayout
            rows: 4
            flow: GridLayout.TopToBottom
            anchors.fill: parent

            Text {
                id: title
                text: "Some sort of title thing"
            }
            Text {
                id: counter
                text: person.counter
            }
            Button {
                id: buttonIncrement
                text: person.counter
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: button.down ? "#d6d6d6" : "#f6f6f6"
                    border.color: "#26282a"
                    border.width: 1
                    radius: 4
                }
                onClicked: person.increment()
            }
            Button {
                id: buttonSet
                text: person.counter
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: button.down ? "#d6d6d6" : "#f6f6f6"
                    border.color: "#26282a"
                    border.width: 1
                    radius: 4
                }
                onClicked: person.setCounter(10);
            }
        }
    }
}
