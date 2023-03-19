

git clone https://github.com/slavojk/logs.git > /dev/null 2>&1 
lfile="logs/file"
./splitFile.sh $lfile > /dev/null
./analyseData.sh
cat output
