#include "makeimage.h"

MakeImage::MakeImage(QObject *parent):QObject(parent)
{
}

QString MakeImage::sendFaultReportRequest(const QStringList &imgList){
    for(int i = 0; i<imgList.length();i++){
        qDebug()<<"==str=="+ imgList.at(i);
    }
    return "111";
}
