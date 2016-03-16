import QtQuick 2.0
import com.syberos.basewidgets 2.0

CPageStackWindow {
    initialPage:CPage{
        width:parent.width
        height:parent.height
        Text {
            text: qsTr("Hello SyberOS")
            anchors.centerIn: parent
        }
    }
}

