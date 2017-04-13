#!/bin/bash

# Usage: ./misc/deploy-windows.sh fileName
#
# This script makes a standalone ZIP package for distribution on Windows.
# Tested on Windows 7/10.
# Use Git Bash or a similar tool to run this. This requires .NET for the archive creation.
# If you don't have that, comment out the last line and make it manually.

name=$1
if [ "$name" == "" ]
then
    name=Elko
fi

folder=`mktemp -d -p .`
folder32=`mktemp -d -p .`

echo -e Deploying to $name.zip and $name-32.zip'\n'

mkdir -p $folder/$name/imageformats
mkdir -p $folder/$name/platforms
mkdir -p $folder/$name/Qt/labs/folderlistmodel
mkdir -p $folder/$name/Qt/labs/settings
mkdir -p $folder/$name/QtQuick/Controls
mkdir -p $folder/$name/QtQuick/Controls.2
mkdir -p $folder/$name/QtQuick/Dialogs
mkdir -p $folder/$name/QtQuick/Dialogs/Private
mkdir -p $folder/$name/QtQuick/Dialogs/qml
mkdir -p $folder/$name/QtQuick/Layouts
mkdir -p $folder/$name/QtQuick/Templates.2
mkdir -p $folder/$name/QtQuick/Window.2
mkdir -p $folder/$name/QtQuick/XmlListModel
mkdir -p $folder/$name/QtQuick.2

mkdir -p $folder32/$name-32/imageformats
mkdir -p $folder32/$name-32/platforms
mkdir -p $folder32/$name-32/Qt/labs/folderlistmodel
mkdir -p $folder32/$name-32/Qt/labs/settings
mkdir -p $folder32/$name-32/QtQuick/Controls
mkdir -p $folder32/$name-32/QtQuick/Controls.2
mkdir -p $folder32/$name-32/QtQuick/Dialogs
mkdir -p $folder32/$name-32/QtQuick/Dialogs/Private
mkdir -p $folder32/$name-32/QtQuick/Dialogs/qml
mkdir -p $folder32/$name-32/QtQuick/Layouts
mkdir -p $folder32/$name-32/QtQuick/Templates.2
mkdir -p $folder32/$name-32/QtQuick/Window.2
mkdir -p $folder32/$name-32/QtQuick/XmlListModel
mkdir -p $folder32/$name-32/QtQuick.2


cp -v `find .. -name Elko.exe | grep Elko| grep 64 | grep Release | grep 5.7` $folder/$name/Elko.exe && elko=OK || elko=fail
cp -v `find .. -name Elko.exe | grep Elko| grep 32 | grep Release | grep 5.7` $folder32/$name-32/Elko.exe && elko32=OK || elko32=fail

QT_DIR=C:/Qt/5.7/msvc2015_64 &&
cp -v $QT_DIR/bin/Qt5Core.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5Gui.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5Network.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5Qml.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5Quick.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5QuickControls2.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5QuickTemplates2.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5Svg.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5Widgets.dll $folder/$name &&
cp -v $QT_DIR/bin/Qt5XmlPatterns.dll $folder/$name &&
cp -v $QT_DIR/plugins/imageformats/qjpeg.dll $folder/$name/imageformats &&
cp -v $QT_DIR/plugins/platforms/qwindows.dll $folder/$name/platforms &&
cp -v $QT_DIR/qml/Qt/labs/folderlistmodel/qmlfolderlistmodelplugin.dll $folder/$name/Qt/labs/folderlistmodel &&
cp -v $QT_DIR/qml/Qt/labs/folderlistmodel/qmldir $folder/$name/Qt/labs/folderlistmodel &&
cp -v $QT_DIR/qml/Qt/labs/settings/qmlsettingsplugin.dll $folder/$name/Qt/labs/settings &&
cp -v $QT_DIR/qml/Qt/labs/settings/qmldir $folder/$name/Qt/labs/settings &&
cp -v $QT_DIR/qml/QtQuick/Controls/qtquickcontrolsplugin.dll $folder/$name/QtQuick/Controls &&
cp -v $QT_DIR/qml/QtQuick/Controls/Splitview.qml $folder/$name/QtQuick/Controls &&
cp -v $QT_DIR/qml/QtQuick/Controls/qmldir $folder/$name/QtQuick/Controls &&
cp -R $QT_DIR/qml/QtQuick/Controls.2 $folder/$name/QtQuick &&
rm $folder/$name/QtQuick/Controls.2/qtquickcontrols2plugind.pdb &&
rm $folder/$name/QtQuick/Controls.2/qtquickcontrols2plugind.dll &&
rm -R $folder/$name/QtQuick/Controls.2/Material &&
rm -R $folder/$name/QtQuick/Controls.2/Universal &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/dialogplugin.dll $folder/$name/QtQuick/Dialogs &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/DefaultFileDialog.qml $folder/$name/QtQuick/Dialogs &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qmldir $folder/$name/QtQuick/Dialogs &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/ColorSlider.qml $folder/$name/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/DefaultWindowDecoration.qml $folder/$name/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/IconButtonStyle.qml $folder/$name/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/IconGlyph.qml $folder/$name/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/icons.ttf $folder/$name/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/qmldir $folder/$name/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/Private/dialogsprivateplugin.dll $folder/$name/QtQuick/Dialogs/Private &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/Private/qmldir $folder/$name/QtQuick/Dialogs/Private &&
cp -v $QT_DIR/qml/QtQuick/Layouts/qquicklayoutsplugin.dll $folder/$name/QtQuick/Layouts &&
cp -v $QT_DIR/qml/QtQuick/Layouts/qmldir $folder/$name/QtQuick/Layouts &&
cp -v $QT_DIR/qml/QtQuick/Templates.2/qtquicktemplates2plugin.dll $folder/$name/QtQuick/Templates.2 &&
cp -v $QT_DIR/qml/QtQuick/Templates.2/qmldir $folder/$name/QtQuick/Templates.2 &&
cp -v $QT_DIR/qml/QtQuick/Window.2/windowplugin.dll $folder/$name/QtQuick/Window.2 &&
cp -v $QT_DIR/qml/QtQuick/Window.2/qmldir $folder/$name/QtQuick/Window.2 &&
cp -v $QT_DIR/qml/QtQuick/XmlListModel/qmlxmllistmodelplugin.dll $folder/$name/QtQuick/XmlListModel &&
cp -v $QT_DIR/qml/QtQuick/XmlListModel/qmldir $folder/$name/QtQuick/XmlListModel &&
cp -v $QT_DIR/qml/QtQuick.2/qtquick2plugin.dll $folder/$name/QtQuick.2 &&
cp -v $QT_DIR/qml/QtQuick.2/qmldir $folder/$name/QtQuick.2 &&
libraries=OK || libraries=fail

QT_DIR=C:/Qt/5.7/msvc2015 &&
cp -v $QT_DIR/bin/Qt5Core.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5Gui.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5Network.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5Qml.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5Quick.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5QuickControls2.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5QuickTemplates2.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5Svg.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5Widgets.dll $folder32/$name-32 &&
cp -v $QT_DIR/bin/Qt5XmlPatterns.dll $folder32/$name-32 &&
cp -v $QT_DIR/plugins/imageformats/qjpeg.dll $folder32/$name-32/imageformats &&
cp -v $QT_DIR/plugins/platforms/qwindows.dll $folder32/$name-32/platforms &&
cp -v $QT_DIR/qml/Qt/labs/folderlistmodel/qmlfolderlistmodelplugin.dll $folder32/$name-32/Qt/labs/folderlistmodel &&
cp -v $QT_DIR/qml/Qt/labs/folderlistmodel/qmldir $folder32/$name-32/Qt/labs/folderlistmodel &&
cp -v $QT_DIR/qml/Qt/labs/settings/qmlsettingsplugin.dll $folder32/$name-32/Qt/labs/settings &&
cp -v $QT_DIR/qml/Qt/labs/settings/qmldir $folder32/$name-32/Qt/labs/settings &&
cp -v $QT_DIR/qml/QtQuick/Controls/qtquickcontrolsplugin.dll $folder32/$name-32/QtQuick/Controls &&
cp -v $QT_DIR/qml/QtQuick/Controls/Splitview.qml $folder32/$name-32/QtQuick/Controls &&
cp -v $QT_DIR/qml/QtQuick/Controls/qmldir $folder32/$name-32/QtQuick/Controls &&
cp -R $QT_DIR/qml/QtQuick/Controls.2 $folder32/$name-32/QtQuick&&
rm $folder32/$name-32/QtQuick/Controls.2/qtquickcontrols2plugind.pdb &&
rm $folder32/$name-32/QtQuick/Controls.2/qtquickcontrols2plugind.dll &&
rm -R $folder32/$name-32/QtQuick/Controls.2/Material &&
rm -R $folder32/$name-32/QtQuick/Controls.2/Universal &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/dialogplugin.dll $folder32/$name-32/QtQuick/Dialogs &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/DefaultFileDialog.qml $folder32/$name-32/QtQuick/Dialogs &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qmldir $folder32/$name-32/QtQuick/Dialogs &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/ColorSlider.qml $folder32/$name-32/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/DefaultWindowDecoration.qml $folder32/$name-32/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/IconButtonStyle.qml $folder32/$name-32/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/IconGlyph.qml $folder32/$name-32/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/icons.ttf $folder32/$name-32/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/qml/qmldir $folder32/$name-32/QtQuick/Dialogs/qml &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/Private/dialogsprivateplugin.dll $folder32/$name-32/QtQuick/Dialogs/Private &&
cp -v $QT_DIR/qml/QtQuick/Dialogs/Private/qmldir $folder32/$name-32/QtQuick/Dialogs/Private &&
cp -v $QT_DIR/qml/QtQuick/Layouts/qquicklayoutsplugin.dll $folder32/$name-32/QtQuick/Layouts &&
cp -v $QT_DIR/qml/QtQuick/Layouts/qmldir $folder32/$name-32/QtQuick/Layouts &&
cp -v $QT_DIR/qml/QtQuick/Templates.2/qtquicktemplates2plugin.dll $folder32/$name-32/QtQuick/Templates.2 &&
cp -v $QT_DIR/qml/QtQuick/Templates.2/qmldir $folder32/$name-32/QtQuick/Templates.2 &&
cp -v $QT_DIR/qml/QtQuick/Window.2/windowplugin.dll $folder32/$name-32/QtQuick/Window.2 &&
cp -v $QT_DIR/qml/QtQuick/Window.2/qmldir $folder32/$name-32/QtQuick/Window.2 &&
cp -v $QT_DIR/qml/QtQuick/XmlListModel/qmlxmllistmodelplugin.dll $folder32/$name-32/QtQuick/XmlListModel &&
cp -v $QT_DIR/qml/QtQuick/XmlListModel/qmldir $folder32/$name-32/QtQuick/XmlListModel &&
cp -v $QT_DIR/qml/QtQuick.2/qtquick2plugin.dll $folder32/$name-32/QtQuick.2 &&
cp -v $QT_DIR/qml/QtQuick.2/qmldir $folder32/$name-32/QtQuick.2 &&
libraries32=OK || libraries32=fail

README='Visual C++ 2015 redistributable is required.\r
\r
Use "./Elko" to launch the program or double-click.\r
'
echo -e "$README" > $folder/$name/README.txt
echo -e "$README" > $folder32/$name-32/README.txt

# Make zip using .Net.
rm -f "$name.zip" "$name-32.zip" &&
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('$folder', '$name.zip'); }" &&
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('$folder32', '$name-32.zip'); }" &&
zip=OK || zip=fail

rm -r $folder $folder32

echo
echo ========= Deployment summary =========
echo "Library                 Status"
echo ======================================
echo "Elko                    $elko"
echo "Elko 32-bit             $elko32"
echo "DLL libraries           $libraries"
echo "DLL libraries 32-bit    $libraries32"
echo "zip                     $zip"

