#!/bin/bash
#
#

usage()
{
    cat << USAGE
        Script that help you rename the project from Template to anything you like
        usage: rename_project  -d dir < -f originName> -t newName
            -d     dir          project root directory
            -f     originName   original project name(default 'Template')
            -t     newName      new project name
            -h     N/A          Print this message
        example:
        $ $0 -d ./  -t newProjectName
USAGE
    exit 0
}

#default 
originName="Template"

while getopts h:d:f:t: arg
do  case $arg in
    h) usage;;
    d) DIR=$OPTARG;;
    f) originName=$OPTARG;;
    t) newName=OPTARG;;
    *) usage;;
esac
done

if [ ! -d "$DIR" ];then
    echo "Error: Directory '$DIR' doesn't exist!"
    usage;
fi

if [ ! -n "$newName" ];then 
    echo "Error: new project name needed!"
    usage;
fi

pushd $DIR
projectFile="$DIR$originName.xcodeproj/project.pbxproj"
if [ ! -f "$projectFile" ];then
    echo "Error:'$projectFile' doesn't exit or not readable!"
fi

# replace
sed 's;$originName;$newName;' $projectFile

# remove xcworkspace and xcuserdata 
rm -rf $originName".xcodeproj/project.xcworkspace"
rm -rf $originName".xcodeporj/xcuserdata"

# rename dir
mv $originName".xcodeproj" $newName".xcodeproj"
mv $originName"Tests" $newName"Tests"
mv $originName $newName

popd

exit 0
