csvDir=$1 #${ZOMBIE_ZOO_CLIENT_ROOT}/config_raw/csv
outputDir=$2 #${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/config
system=$(uname)

cd ${ZOMBIE_ZOO_CLIENT_ROOT}/tools/xls2json
 # {"text":"Actionscript",           "id":"as",               "notes":""},
 #                                {"text":"ASP/VBScript",           "id":"asp",              "notes":""},
 #                                {"text":"HTML",                   "id":"html",             "notes":""},
 #                                {"text":"JSON - Properties",      "id":"json",             "notes":""},
 #                                {"text":"JSON - Column Arrays",   "id":"jsonArrayCols",    "notes":""},
 #                                {"text":"JSON - Row Arrays",      "id":"jsonArrayRows",    "notes":""},
 #                                {"text":"MySQL",                  "id":"mysql",            "notes":""},
 #                                {"text":"PHP",                    "id":"php",              "notes":""},
 #                                {"text":"Python - Dict",          "id":"python",           "notes":""},
 #                                {"text":"Ruby",                   "id":"ruby",             "notes":""},
 #                                {"text":"XML - Properties",       "id":"xmlProperties",    "notes":""},
 #                                {"text":"XML - Nodes",            "id":"xml",              "notes":""},
 #                                {"text":"XML - Illustrator",      "id":"xmlIllustrator",   "notes":""}];
outputdatatypes=("jsonArrayRows" "jsonArrayCols" "json")

office_cmd=libreoffice
echo system is ${system}
if [ ${system} = Darwin ]; then 
	office_cmd=/Applications/LibreOffice.app/Contents/MacOS/soffice
fi

#转换csv
for i in ${outputdatatypes[@]}; do
	echo '##################' start processing ..$i '##################'
	inputdir=${csvDir}/${i}
	echo inputdir is ${inputdir}

	#开始处理xls下的文件
	for file in $(ls ${inputdir}); do
		echo 	--------------------------------------------------------
		inputfile=${inputdir}/${file}
		outputfile=${outputDir}/${file%.*}.json
		echo 	inputfile is ${inputfile}
		echo 	json filename is ${outputfile} ${outputdatatype}
		#直接用工具进行转换
		node main.js ${inputfile} ${outputfile} ${i}
		echo 	--------------------------------------------------------
	done

	echo '##################' end process ..$i '##################'

done

echo \\n\\n\\nFinish convert xls to json.
