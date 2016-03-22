var assert = require('assert')

function main()
{
	var fs = require("fs")
	var args = process.argv.splice(2);

	var input = args[0];
	var output = args[1];
	var jstype = args[2];
	console.log("inputFile is : %s\noutputfile is %s\njstype is %s\n", input, output, jstype);

	var inputdata = fs.readFileSync(input, 'utf8');

	assert(inputdata, "can't find input file!");
	
	console.log("*************** inputdata is:\n %s", inputdata)


	var convertor = require("./converter");
	var DataConverter = new convertor.DataConverter(jstype);
	DataConverter.convert(inputdata);
	

	fs.writeFileSync(output, DataConverter.outputText, 'utf8');

}

main()