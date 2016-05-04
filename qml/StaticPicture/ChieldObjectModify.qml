import QtQuick 2.0
Rectangle{
    id:chieldObj
    property int chield_reversal:0
    property string chield_url:""
    property string parent_width:""
    property string parent_height:""
    property string chield_index:""
    property string chield_x:""
    property string chield_y:""
    property string chield_rotate:""
    property string chield_imagetype:""
    property int pressFlag:0
    property int countFlag:0
    property real countScale:1.0
    property int lastx:0
    property int lasty:0
    property int oldType:0
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
        onImageReversal:{
            if(chieldObj.focus==true){
                if(chieldObj.chield_reversal==0){
                    expressionImage.mirror = true
                    chieldObj.chield_reversal=1
                }else{
                    expressionImage.mirror = false
                    chieldObj.chield_reversal=0
                }
            }
        }
     }

    Image {
        id:expressionImage
        mirror:chield_reversal==0?false:true
        source: chieldObj.chield_url;
        anchors.fill: parent
        anchors.margins: 2
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
        pinch.maximumScale: 2;
        pinch.minimumScale: 0.2;
        pinch.minimumRotation: -360000;
        pinch.maximumRotation: 3600000;
        onPinchStarted: {
            console.log("=======pinch.center.x===00==="+pinch.center.x)
            console.log("=======pinch.center.y===00==="+pinch.center.y)
        }
        onPinchUpdated: {

        }
        onPinchFinished: {
            console.log("=======pinch.scale======"+pinch.scale)
            countScale = countScale*pinch.scale
            console.log("=======countScale======"+countScale)
            console.log("=======pinch.center.x===11==="+pinch.center.x)
            console.log("=======pinch.center.y===11==="+pinch.center.y)
//            chieldObj.chield_x = (chieldObj.x - (chieldObj.width/2)*(pinch.scale-1))
//            chieldObj.chield_y = (chieldObj.y - (chieldObj.height/2)*(pinch.scale-1))

        }
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
        console.log("=========onXChanged========");
    }
    onYChanged: {
        chield_y = y;
        console.log("=========chield_y========");
    }
    onWidthChanged: {
        console.log("=========onWidthChanged========");
    }
    onHeightChanged: {
        console.log("=========onHeightChanged========");
    }
    onRotationChanged: {
        console.log("=========onRotationChanged========"+chieldObj.rotation);
        chield_rotate = chieldObj.rotation%360;
    }

    Component.onCompleted: {
//        if(oldType!=0){
            chieldObj.focus=true;
            chieldObj.border.color="#0ced8b"
//        }
        console.log("=========x===="+x);
        console.log("=========y===="+y);
        console.log("=========chieldObj.width===="+chieldObj.width);
        console.log("=========chieldObj.height===="+chieldObj.height);
        console.log("=========yuan_x===="+(x+chieldObj.width));
        console.log("=========yuan_y===="+(y+chieldObj.height));
        console.log("=========parent_width===="+parent_width);
        console.log("=========parent_height===="+parent_height);
    }
}
