#include "makeimage.h"

MakeImage::MakeImage(QObject *parent):QObject(parent)
{
}

QString MakeImage::makeStaticImage(int size,int Bgwidht,int Bgheight,const QStringList &imgList){
    QPixmap *pix=new QPixmap(QSize(Bgwidht/size,Bgheight/size));
    pix->fill(Qt::white);
    QPainter paint(pix);
    for(int i = 0; i<imgList.length();i++){
        QString strTmp=imgList.at(i);
        QStringList strlTmp = strTmp.split("=");
        QString xTmp = this->processingString(strlTmp.at(1));
        QString yTmp = this->processingString(strlTmp.at(2));
        QString widhtTmp = this->processingString(strlTmp.at(3));
        QString heightTmp = this->processingString(strlTmp.at(4));
        QString rotatetTmp = this->processingString(strlTmp.at(5));
        QString urlTmp = strlTmp.at(6);
        QString reversalTmp = strlTmp.at(7);
        QString imagetypeTmp = strlTmp.at(8);

        if(imagetypeTmp=="0"){
            urlTmp = urlTmp.mid(urlTmp.lastIndexOf("/"),urlTmp.length()-1);
            urlTmp = ":res"+urlTmp.mid(0,urlTmp.lastIndexOf("_"))+urlTmp;
        }else{
            urlTmp = urlTmp.replace("file:/","");
        }

        if(reversalTmp=="0"){
            if(rotatetTmp==""){
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap(urlTmp));
            }else{
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap(urlTmp).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }else if(reversalTmp=="1"){
            if(rotatetTmp==""){
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap::fromImage(QImage(urlTmp).mirrored(true, false)));
            }else{
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap::fromImage(QImage(urlTmp).mirrored(true, false)).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }
        qDebug()<<"==urlTmp=="+ urlTmp;
    }
    QDateTime current_date_time = QDateTime::currentDateTime();
    QString current_date = current_date_time.toString("yyyyMMdd_hhmmss");
    QString returnVlaue = "/data/home/user/DCIM/Camera/PaintBox_"+current_date+".jpg";
    pix->save(returnVlaue);
    return returnVlaue;
}
QString MakeImage::processingString(QString strTmp){
    QString returnValue = strTmp;
    returnValue = returnValue.left(returnValue.trimmed().indexOf("."));
//    qDebug()<<"=processingString=returnValue=="+returnValue;
    return returnValue;
}
