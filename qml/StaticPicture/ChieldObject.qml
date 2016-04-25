import QtQuick 2.0
Rectangle{
    id:chieldObj
    property string chield_url:""
    property string parent_width:""
    property string parent_height:""
    property string chield_index:""
    property string chield_x:""
    property string chield_y:""
    property string chield_rotate:""
    property int pressFlag:0
    property int countFlag:0
    property int lastx:0
    property int lasty:0
    color:"#00000000"
    x:0
    y:0
    width:10
    height: 10
    border.color: chieldObj.focus==true?"#0ced8b":"#00000000"
    border.width: chieldObj.focus==true?2:0
    Connections{
        target: makeStaticPicture
        onDeleteFocus:{
            chieldObj.focus = false;
        }
    }

    Image {
        source: chieldObj.chield_url;
        anchors.fill: parent
    }

    onFocusChanged: {
        if(chieldObj.focus!=true){
            chieldObjPinchArea.visible=false
        }
        chieldObjMouseArea.visible=true
    }

    MouseArea{
        id:chieldObjMouseArea
        visible:false
        anchors.fill: chieldObj
        drag.target: chieldObj.focus==true?chieldObj:null
        drag.axis: "XAndYAxis"//XAxis//XAndYAxis//YAxis
        drag.minimumX: 0
        drag.maximumX: parent_width-chieldObj.width+40
        drag.minimumY: 0
        drag.maximumY: parent_height-chieldObj.height
        onClicked: {
            console.log("==========clicked=============");
            if(chieldObj.focus==false){
                chieldObj.border.color="#0ced8b"
            }
            chieldObj.focus=true
            chieldObjMouseArea.visible = true;
        }
    }

    PinchArea {
        id:chieldObjPinchArea
        anchors.fill: chieldObj
        pinch.target: chieldObj
        visible:false
        pinch.maximumScale: 20;
        pinch.minimumScale: 0.2;
        pinch.minimumRotation: 0;
        pinch.maximumRotation: 90;
    }

    Image {
        id:rotateImage
        z:2
        visible: chieldObj.focus==true
        source: "qrc:/res/rotate.png";
        anchors.right: parent.right
        anchors.rightMargin: -25
        anchors.bottom:parent.bottom
        anchors.bottomMargin: -25
        MouseArea{
            id:rotateImageMouseArea
            anchors.fill: parent
            onClicked: {
                console.log("==========rotate=============");
                chieldObj.border.color="#fce277"
                chieldObjMouseArea.visible = false;
                chieldObjPinchArea.visible = true;
            }
        }
    }
    Image {
        id:moveImage
        z:2
        visible: chieldObj.focus==true
        source: "qrc:/res/move.png";
        anchors.left: parent.left
        anchors.leftMargin: -25
        anchors.top:parent.top
        anchors.topMargin: -25
        MouseArea{
            id:moveImageMouseArea
            anchors.fill: parent
            onClicked: {
                console.log("==========move=============");
                chieldObj.border.color="#0ced8b"
                chieldObjMouseArea.visible = true;
                chieldObjPinchArea.visible = false;
            }
        }
    }
    onXChanged: {
        chield_x = x;
    }
    onYChanged: {
        chield_y = y;
    }
    Component.onCompleted: {
        chieldObj.focus=true;
        chieldObj.border.color="#0ced8b"
    }
}
