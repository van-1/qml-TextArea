import QtQuick 2.8
import QtQuick.Controls 2.2

Flickable {
  id: flickable
  property alias msgToSend: textInput.text
  property alias backgroundColor: textInput.backgroundColor
  property alias maximumTextLength: textInput.maximumLength

  TextArea.flickable: TextArea {
    id: textInput
    property int maximumLength: 2048
    property string previousText: text
    property alias backgroundColor: backgroundRect.color

    wrapMode: TextArea.Wrap
    textFormat: TextArea.PlainText
    selectByMouse: true
    topPadding: 10
    leftPadding: 10
    placeholderText: qsTr("Enter text...")
    background: Rectangle {
      id: backgroundRect
      implicitWidth: parent.width
      implicitHeight: parent.height
      color: "white"
    }

    font.pixelSize: 13
    font.family: "Roboto"

    Keys.onPressed: {
      var re = /[a-zA-Z\d\s\(\)\?\.";,#№:;\+-/'\*]{1,2048}/;
      var allowedKeys = [Qt.Key_Backspace, Qt.Key_Delete, Qt.Key_Up, Qt.Key_Down, Qt.Key_Left, Qt.Key_Right, Qt.Key_A, Qt.Key_V, Qt.Key_C, Qt.Key_Z];
      if (allowedKeys.indexOf(event.key) < 0) {
       if (!re.test(event.text)) {
            event.accepted = true
        }
      }
    }

    onTextChanged: {
      var cursor = cursorPosition;
      if (text.length > maximumLength) {
        text = previousText;
        if (cursor > text.length) {
          cursorPosition = text.length;
        } else {
          cursorPosition = cursor - 1;
        }
      }
      previousText = text
    }
  }

  ScrollBar.vertical: ScrollBar {
    policy: contentHeight > height ? ScrollBar.AlwaysOn : ScrollBar.AsNeeded
    interactive: true
  }
}
