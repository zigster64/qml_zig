import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

ApplicationWindow {
  width: 400
  height: 300
  title: "Passing Variants from Zig"
  visible: true

  ColumnLayout
  {
    anchors.fill: parent
    Text{
      text: "Wait"
      Component.onCompleted: text = testArrayProperty()

      function testArrayProperty() {
        if (typeof values == 'undefined')
          return "No array"
        return values[0] == 42 && values[1] == 43
      }
    }
    TextField { text: title_field }
    SpinBox { value: qVar1 }
    TextField { text: qVar2 }
    CheckBox { checked: qVar3 }
    SpinBox { value: qVar4; decimals: 2 }
  }
}
