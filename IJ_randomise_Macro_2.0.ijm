macro "" {
	getDateAndTime(year, month, week, day, hour, min, sec, msec);
	run("Close All");
	print("\\Clear")
	run("Clear Results");
	updateResults;
	roiManager("reset");
	print("Start process at: "+day+"/"+month+"/"+year+" :: "+hour+":"+min+":"+sec+"");
	dir1=getDirectory("Please choose directory containing the images");
	list=getFileList(dir1);
	dir2=getDirectory("_Please choose destination directory ");
	print("___");
	print("processing directory: "+dir1+"");
	print("___");
	//setBatchMode(true);
	while (nImages>0) {				
		selectImage(nImages);
		close();
	}
	N=0;
	rname=123456789;
	for (i=0; i<list.length; i++) {
		N++;
		print("Image: "+N+"");
		path = dir1+list[i];
		open(""+path+"");
		title1= getTitle;
		title1w = File.nameWithoutExtension;
		print("original image title: "+title1+"");
		selectWindow("Results");
		setResult("original filename", nResults, title1w);	
		rname = round(random()*1000000000);
		print("random image title: "+rname+".tif");
		selectWindow("Results");
		setResult("randomised filename", nResults-1, rname);	
		selectWindow(""+title1+"");
		rename(""+rname+".tif");
		title2= getTitle;
		saveAs("tif", dir2+title2+"");
		close();
	//	run("Save");
		print("saved as "+dir2+title2+"");
		print("___");
	}
		selectWindow("Results");
		saveAs("txt", ""+dir2+"filenames.xls");
		print(""+N+" images randomised - see "+dir2+"");
		print("Finished process at: "+day+"/"+month+"/"+year+" :: "+hour+":"+min+":"+sec+"");
		selectWindow("Log");
		saveAs("Text", ""+dir2+"/log_randomisation_"+day+"-"+month+"-"+year+"_"+hour+"h"+min+"min.txt");
		showMessage("Report", ""+N+" images randomised - see "+dir2+"");
}
//JW_01.08.22