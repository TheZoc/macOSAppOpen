QT += quick widgets

CONFIG += c++11 app_bundle

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        helper.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

top_srcdir=$$PWD
top_builddir=$$shadowed($$PWD)

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

VERSION_HEADER = $$PWD/version.h
VERSION_MAJOR = 1
VERSION_MINOR = 0
VERSION_PATCH = 0

VERSION_GIT_SHA1 = $$system(git --git-dir="$$PWD/../.git" rev-parse --short HEAD)
VERSION_GIT_BRANCH_NAME = $$system(git --git-dir="$$PWD/../.git" rev-parse --abbrev-ref HEAD)

versionconfig.input = $$PWD/version.h.in
versionconfig.output = $$VERSION_HEADER
QMAKE_SUBSTITUTES += versionconfig
HEADERS += $$VERSION_HEADER \
    $$PWD/version.h.in

# Info.plist generation
mac {
    handler_rank = Owner

#    ICON = $$PWD/assets/CrashTestIcon.icns

    PACKAGE_ICON_FILES.files = $$PWD/assets/CrashTestIcon.icns
    PACKAGE_ICON_FILES.path = Contents/Resources
    QMAKE_BUNDLE_DATA *= PACKAGE_ICON_FILES
    INFO_PLIST_EXTRA_ENTRIES += "<key>CFBundleDocumentTypes</key>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "    <array>"$$escape_expand(\n)
    INFO_PLIST_EXTRA_ENTRIES += "        <dict>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <key>CFBundleTypeExtensions</key>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <array>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "                <string>macoscrashtest</string>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            </array>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <key>CFBundleTypeIconFile</key>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <string>CrashTestIcon.icns</string>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <key>CFBundleTypeName</key>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <string>macOS Crash Test Package</string>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <key>CFBundleTypeRole</key>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <string>Editor</string>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <key>LSHandlerRank</key>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <string>$${handler_rank}</string>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <key>LSTypeIsPackage</key>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "            <true/>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "        </dict>$$escape_expand(\n)"
    INFO_PLIST_EXTRA_ENTRIES += "    </array>$$escape_expand(\n)"
    QMAKE_INFO_PLIST = $$OUT_PWD/Info.plist

    infoplist.input = $$PWD/Info.plist.in
    infoplist.output = $${QMAKE_INFO_PLIST}
    QMAKE_SUBSTITUTES += infoplist

    QMAKE_POST_LINK = echo "=============== POST_LINK ================";
    QMAKE_POST_LINK += echo $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$${TARGET}.app -verbose=1 -qmldir=$$top_srcdir -executable=$$OUT_PWD/$${TARGET}.app/Contents/MacOS/$${TARGET};
    QMAKE_POST_LINK += $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$${TARGET}.app -verbose=1 -qmldir=$$top_srcdir -executable=$$OUT_PWD/$${TARGET}.app/Contents/MacOS/$${TARGET};
}

HEADERS += \
    helper.h \
    main.h
