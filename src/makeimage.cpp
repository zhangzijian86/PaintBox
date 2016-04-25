#include "makeimage.h"

MakeImage::MakeImage(QObject *parent):QObject(parent)
{
}

QString MakeImage::makeStaticImage(int Bgwidht,int Bgheight,const QStringList &imgList){
    QPixmap *pix=new QPixmap(QSize(Bgwidht/3,Bgheight/3));
    pix->fill(Qt::white);
    QPainter paint(pix);
    for(int i = 0; i<imgList.length();i++){
        QString strTmp=imgList.at(i);
        QStringList strlTmp = strTmp.split("-");
        QString xTmp = this->processingString(strlTmp.at(1));
        QString yTmp = this->processingString(strlTmp.at(2));
        QString widhtTmp = this->processingString(strlTmp.at(3));
        QString heightTmp = this->processingString(strlTmp.at(4));
        QString rotatetTmp = this->processingString(strlTmp.at(5));
        QString urlTmp = strlTmp.at(6);
        urlTmp = urlTmp.mid(urlTmp.lastIndexOf("/"),urlTmp.length()-1);
        urlTmp = ":res"+urlTmp;
        if(rotatetTmp==""){
            paint.drawPixmap(xTmp.toInt()/3,yTmp.toInt()/3,widhtTmp.toInt()/3,heightTmp.toInt()/3,QPixmap(urlTmp));
        }else{
            QMatrix leftmatrix;
            leftmatrix.rotate(rotatetTmp.toInt());
            paint.drawPixmap(xTmp.toInt()/3,yTmp.toInt()/3,widhtTmp.toInt()/3,heightTmp.toInt()/3,QPixmap(urlTmp).transformed(leftmatrix,Qt::SmoothTransformation));
        }
        qDebug()<<"==urlTmp=="+ urlTmp;
    }
    pix->save("./66.jpg");
    return "111";
}
QString MakeImage::processingString(QString strTmp){
    QString returnValue = strTmp;
    returnValue = returnValue.left(returnValue.trimmed().indexOf("."));
    qDebug()<<"=processingString=returnValue=="+returnValue;
    return returnValue;
}
