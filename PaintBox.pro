#-------------------------------------------------
#
# Project generated by QtCreator for SyberOS.
#
#-------------------------------------------------

QML_IMPORT_PATH = $$[QT_INSTALL_QML]

RESOURCES += res.qrc

CONFIG += link_pkgconfig

PKGCONFIG += syberos-application syberos-application-cache

# This is needed for using syberos-application and syberos-qt module
INCLUDEPATH += $$[QT_INSTALL_HEADERS]/../syberos_application \
			   $$[QT_INSTALL_HEADERS]/../framework

QT += gui qml quick

TARGET = PaintBox

#Please Do not modify these macros, otherwise your app will not installed correctly and will not run at all.
APP_DIR = /data/apps
APP_DATA = /data/data
INS_DIR = $$APP_DIR/com.pg.PaintBox
DATA_DIR = $$APP_DATA/com.pg.PaintBox

DEFINES += SOP_ID=\\\"com.pg.PaintBox\\\"
DEFINES += APP_DIR_ENVVAR=\\\"APPDIR_REGULAR\\\"
# Currently home screen sets the environment variable, so when run from
# elsewhere, use this work-around instead.
DEFINES += APP_DIR=\\\"$$APP_DIR\\\"

# The .cpp file which was generated for your project.
SOURCES += src/main.cpp \
           src/PaintBox_Workspace.cpp

HEADERS += src/PaintBox_Workspace.h

# Installation path
target.path = $$INS_DIR/bin

res.files = res
res.path = $$INS_DIR/

meta.files = META-INF
meta.path = $$INS_DIR/

syber.files = sopconfig.xml
syber.path = $$INS_DIR/

INSTALLS += target res meta syber

QML_FILES = qml/*.qml

OTHER_FILES += $$QML_FILES *.qm \
    qml/makePicture.qml \
    qml/makeDynamicPicture.qml \
    qml/makeStaticPicture.qml \
    qml/StaticPicture/makeStaticPicture.qml
               


