#ifndef MAKEIMAGE_H
#define MAKEIMAGE_H

#include <QObject>
#include <QFileInfoList>
#include <QFileInfo>
#include <QDateTime>
#include <QPainter>
#include <QPixmap>
#include <QImage>
#include <QDebug>
#include <QDir>



class MakeImage : public QObject
{
    Q_OBJECT

public:
    explicit MakeImage(QObject *parent = 0);
    Q_INVOKABLE QString makeStaticImage(int size,int Bgwidht,int Bgheight,const QStringList &imgList);
    Q_INVOKABLE QString getAllImages();
    QString processingString(QString strTmp);
};

#endif // MAKEIMAGE_H
