#!/bin/bash
#
#

usage()
{
    cat << USAGE
        Script that help you rename the project from Template to anything you like
        usage: rename_project  -d dir < -f OriginName> -t NewName
            -d     dir          project root directory
            -f     OriginName   Original project name(default 'Template')
            -t     NewName      New project name
            -h     N/A          Print this message
        example:
        $ $0 -d ./  -t NewProjectName
USAGE
    exit 0
}

#default 
OriginName="Template"
DIR=  NewName= 
while getopts h:d:f:t: arg
do  case $arg in
    h) usage;;
    d) DIR=$OPTARG;;
    f) OriginName=$OPTARG;;
    t) NewName=$OPTARG;;
    *) usage;;
esac
done

if [ ! -d "$DIR" ];then
    echo "Error: Directory '$DIR' doesn't exist!"
    usage;
fi

if [ ! -n "$NewName" ];then 
    echo "Error: New project name needed!"
    usage;
fi

pushd $DIR
projectFile="$DIR$OriginName.xcodeproj/project.pbxproj"
if [ ! -f "$projectFile" ];then
    echo "Error:'$projectFile' doesn't exit or not readable!"
fi

set -x
# replace
sed "s;$OriginName;$NewName;g" $projectFile > $projectFile".bk"
rm $projectFile
mv $projectFile".bk" $projectFile

# remove xcworkspace and xcuserdata 
rm -rf $OriginName".xcodeproj/project.xcworkspace"
rm -rf $OriginName".xcodeporj/xcuserdata"

# rename Info.plist and Prefix.pch 
pushd $OriginName
mv $OriginName"-Info.plist" $NewName"-Info.plist"
mv $OriginName"-Prefix.pch" $NewName"-Prefix.pch"
popd 

pushd $OriginName"Tests"
mv $OriginName"Tests-Info.plist"  $NewName"Tests-Info.plist"
popd

# rename dir
mv $OriginName".xcodeproj" $NewName".xcodeproj"
mv $OriginName"Tests" $NewName"Tests"
mv $OriginName $NewName

set +x
popd

exit 0
