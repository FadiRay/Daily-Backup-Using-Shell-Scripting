# Checking if the number of arguments is correct
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# Checking if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# Setting two variables equal to the values of the arguments
targetDirectory=$1
destinationDirectory=$2

# Defining a timestamped variable called backupFileName to store the name of the archived and compressed backup file
# that the script will create.
currentTS=`date +%s`
backupFileName="backup-[$currentTS].tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# The absolute path of the current directory
origAbsPath=`pwd`

# The absolute path of the destination directory
cd $destinationDirectory
destDirAbsPath=`pwd`

# Changing directories from the current working directory to the target directory
cd $origAbsPath 
cd $targetDirectory

# Finding files that have been updated within the past 24 hours
yesterdayTS=$(($currentTS - 24 * 60 * 60))
declare -a toBackup

for file in $(ls)
do
  if ((`date -r $file +%s` > $yesterdayTS))
  then
    toBackup+=($file)
  fi
done

# Compressing and archiving the files
tar -czvf $backupFileName ${toBackup[@]}

# Moving the file backupFileName to the destination directory
mv backupFileName $destAbsPath

# This is a modified version of a project from an IBM course!