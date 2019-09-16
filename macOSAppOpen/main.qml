import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("macOS Crash test")

    RowLayout
    {
        Label {
            text: "Info: "
        }
        Label {
            id: txt
            text: helper.testMessage
        }
    }
}
