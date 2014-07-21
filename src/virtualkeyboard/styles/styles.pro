TEMPLATE = lib
TARGET = qtvirtualkeyboardstylesplugin
android-no-sdk {
    INSTALL_PATH = /system/qml/QtQuick/Enterprise/VirtualKeyboard/Styles
} else:!isEmpty(CROSS_COMPILE) {
    INSTALL_PATH = /usr/local/Qt-$$[QT_VERSION]/qml/QtQuick/Enterprise/VirtualKeyboard/Styles
} else {
    INSTALL_PATH = $$[QT_INSTALL_QML]/QtQuick/Enterprise/VirtualKeyboard/Styles
}
QT += qml quick
CONFIG += qt plugin

target.path = $$INSTALL_PATH
INSTALLS += target

qtquickcompiler {
    TARGETPATH = QtQuick/Enterprise/VirtualKeyboard/Styles
    # without the next line it fails to compile - QTRD-3291
    CONFIG += qtquickcompiler
    DEFINES += COMPILING_QML
    DEFINES += STYLES_IMPORT_PATH=\\\"qrc:/\\\"
} else {
    DEFINES += STYLES_IMPORT_PATH=\\\"file://$$INSTALL_PATH/\\\"
}

SOURCES += \
    styles_plugin.cpp

HEADERS += \
    styles_plugin.h

QML_FILES += \
    qmldir \
    KeyboardStyle.qml \
    KeyPanel.qml \
    KeyIcon.qml \
    SelectionListItem.qml

qtquickcompiler {
    # generate qrc file, this should work out-of-box with later releases of qtquickcompiler
    include(../generateresource.prf)
    RESOURCES += $$generate_resource(styles.qrc, $$QML_FILES)
}

OTHER_FILES += \
    plugins.qmltypes

qtquickcompiler {
    other.files = $$OTHER_FILES qmldir
} else {
    other.files = $$OTHER_FILES $$QML_FILES
}
other.path = $$INSTALL_PATH
INSTALLS += other
