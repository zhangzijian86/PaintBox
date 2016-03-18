import QtQuick 2.0
import com.syberos.basewidgets 2.0

Rectangle {
    anchors.fill: parent
    Rectangle{
        anchors.fill: parent
        color: "yellow"
    }
    CButton{
        text:"qihuandao--my"
        onClicked:{
            mainPage.changePage("myPicture.qml");
        }
    }
}
