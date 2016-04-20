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
    border.color: chieldObj.focus==true?"#fce277":"#00000000"
    border.width: chieldObj.focus==true?2:0
    Connections{
        target: makeStaticPicture
        onDeleteFocus:{
            chieldObj.focus = false;
        }
    }
    Rectangle{
        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        height: parent.height-5
        Image {
            source: chieldObj.chield_url;
            anchors.fill: parent
        }
        MouseArea{
            id:chieldObjMouseArea
            anchors.fill: parent
            drag.target: chieldObj.focus==true?chieldObj:null
            drag.axis: "XAndYAxis"//XAxis//XAndYAxis//YAxis
            drag.minimumX: 0
            drag.maximumX: parent_width-chieldObj.width+40
            drag.minimumY: 0
            drag.maximumY: parent_height-chieldObj.height
            onClicked: {
                chieldObj.focus=true
            }
        }
//        onFocusChanged: {
//            console.log("=========chieldObjMouseArea==onFocusChanged========="+chieldObj.focus);
//        }

        PropertyAnimation{
            id:rotate
            target:chieldObj
            properties:"rotation"
            from : 0
            to:90
            duration:10
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
            drag.target: pressFlag==1?rotateImage:null
            drag.axis: "XAndYAxis"//XAxis//XAndYAxis//YAxis
            drag.minimumX: 0
            drag.maximumX: chieldObj.width
            drag.minimumY: 0
            drag.maximumY: chieldObj.height
            onPressed: {
                pressFlag = 1;
            }
            onReleased: {
                pressFlag = 0;
            }
            onMouseXChanged: {
                if(pressFlag==1&&countFlag%5==0){
                    rotate.from = chieldObj.rotation
                    if(lastx<mouseX){
                        rotate.to = chieldObj.rotation-5
                        chield_rotate = chieldObj.rotation-5
                    }
                    if(lastx>mouseX){
                        rotate.to = chieldObj.rotation+5
                        chield_rotate = chieldObj.rotation+5
                    }
                    rotate.running=true;
                    lastx = mouseX;
                    lasty = mouseY;
                }
                countFlag++;
            }
        }
    }
    onXChanged: {
        console.log("====chield_x==00=="+chield_x);
        chield_x = x;
        console.log("====chield_x==11=="+chield_x);
    }
    onYChanged: {
        console.log("====chield_y==00=="+chield_y);
        chield_y = y;
        console.log("====chield_y==11=="+chield_y);
    }
    Component.onCompleted: {
        chieldObj.focus=true
        console.log("===x======"+x);
        console.log("===x======"+y);
        console.log("===chield_index======"+chield_index);
    }
}
