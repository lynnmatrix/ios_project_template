#! /bin/sh
#

usage()
{
    cat <<-EOF >&2

    Script that help you rename the project from Template to anything you like
    usage: ./${0##*/}  -d dir < -f originName> -t newName
    -d     dir          project root directory
    -f     originName   original project name(default 'Template')
    -t     newName      new project name
    -h     N/A          Print this message
    example:
    $ $0 -d ./  newProjectName
    EOF
    exit 0
}

#default 
originName="Template"

while getopts h:d:f:t arg
do  case $arg in
    h) usage;;
    d) DIR="$OPTARG"
    f) originName="$OPTARG";;
    t) newName="OPTARG";;
    *) usage;;
esac
done

[ -d "$DIR" ]|| \
    {
        echo "Error: Directory '$DIR' doesn't exist!"
        usage
    }
[ -n "$newName" ] \
    {
    echo "Error: new project name needed!"
    usage
    }
pushd $DIR
projectFile="$originName.xcodeproj/project.pbxproj"
[ -f "$projectFile" ] || \ 
{
    echo "Error:'$projectFile' doesn't exit or not readable!"
}
sed 's;$originName;$newName;' $projectFile

# remove xcworkspace and xcuserdata 
rm -rf $originName".xcodeproj/project.xcworkspace"
rm -rf $originName".xcodeporj/xcuserdata"

# rename dir
mv $originName##.xcodeproj $newName##.xcodeproj
mv $originName##Tests $newName##Tests
mv $originName $newName
popd


