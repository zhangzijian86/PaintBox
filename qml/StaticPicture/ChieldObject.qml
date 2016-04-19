import QtQuick 2.0
Rectangle{
    id:chieldObj
    property string chield_url:""
    property string parent_width:""
    property string parent_height:""
    property int flag:0
    color:"#00000000"
    x:0
    y:0
//    z:0
    width:10
    height: 10
    border.color: "#00000000"
    border.width: 0
    Image {
        source: chieldObj.chield_url;
        anchors.fill: parent
    }
    MouseArea{
        id:chieldObjMouseArea
        anchors.fill: parent
        drag.target: flag==1?chieldObj:null
        drag.axis: "XAndYAxis"//XAxis//XAndYAxis//YAxis
        drag.minimumX: 0
        drag.maximumX: parent_width-chieldObj.width+40
        drag.minimumY: 0
        drag.maximumY: parent_height-chieldObj.height
        onClicked: {
            chieldObj.border.color="#fce277";
            chieldObj.border.width=2;
            flag=1;
        }
    }
    onFocusChanged: {
        console.log("=========chieldObjMouseArea==onFocusChanged=========");
    }
}
