//Gather names of all opened images
	numberOfImages = nImages();
	if (numberOfImages == 0) {
		showMessage("No images opened!");
		exit;
	}

	imageTitles = newArray(numberOfImages);
	for (i = 1; i <= numberOfImages; i++) {
		selectImage(i);
		imageTitles[i-1] = getTitle();
	}

//Display the dialog
	Dialog.create("Select an Image");
	Dialog.addChoice("vis1:", imageTitles);
	Dialog.addChoice("wb1:", imageTitles);
	Dialog.addChoice("vis2:", imageTitles);
	Dialog.addChoice("wb2:", imageTitles);
	Dialog.show();

//Get selected image titles
	VIS1 = Dialog.getChoice();
	WB1 = Dialog.getChoice();
	VIS2 = Dialog.getChoice();
	WB2 = Dialog.getChoice();

//Get the image width, height and bitdepth. Then rename them
	selectWindow(VIS1);
	VIS1_W = getWidth();
	VIS1_H = getHeight();
	VIS1_BD = bitDepth();
	VIS1 = "VIS1.TIF";
	rename(VIS1);

	selectWindow(VIS2);
	VIS2_W = getWidth();
	VIS2_H = getHeight();
	VIS2_BD = bitDepth();
	VIS2 = "VIS2.TIF";
	rename(VIS2);

	selectWindow(WB1);
	WB1_W = getWidth();
	WB1_H = getHeight();
	WB1_BD = bitDepth();
	WB1 = "WB1.TIF";
	rename(WB1);

	selectWindow(WB2);
	WB2_W = getWidth();
	WB2_H = getHeight();
	WB2_BD = bitDepth();
	WB2 = "WB2.TIF";
	rename(WB2);

//Print some information for debugging
	print("VIS1: " + VIS1);
	print("VIS1 size (WxH): (" + VIS1_W + ", " + VIS1_H + ")");
	print("VIS1 Bitdepth: (" + VIS1_BD + ")");

	print("WB1: " + WB1);
	print("WB1 size (WxH): (" + WB1_W + ", " + WB1_H + ")");
	print("WB1 Bitdepth: (" + WB1_BD + ")");

	print("VIS2: " + VIS2);
	print("VIS2 size (WxH): (" + VIS2_W + ", " + VIS2_H + ")");
	print("VIS2 Bitdepth: (" + VIS2_BD + ")");

	print("WB2: " + WB2);
	print("WB2 size (WxH): (" + WB2_W + ", " + WB2_H + ")");
	print("WB2 Bitdepth: (" + WB2_BD + ")");

//Resize all the images
	selectWindow(VIS1);
	run("Size...", "width=WB1_W height=WB1_H depth=3 average interpolation=Bilinear");
	selectWindow(VIS2);
	run("Size...", "width=WB1_W height=WB1_H depth=3 average interpolation=Bilinear");
	selectWindow(WB1);
	run("Size...", "width=WB1_W height=WB1_H depth=1 average interpolation=Bilinear");
	selectWindow(WB2);
	run("Size...", "width=WB1_W height=WB1_H depth=1 average interpolation=Bilinear");

//Draw ROI for VIS1
	// Display instruction for user to draw the ROI
	setTool("line");
	selectImage(VIS1);
	waitForUser("Draw a ROI on the image titled '" + VIS1 + "' and then click OK.");

	// Check if a straight line ROI has been drawn on the specific image
	selectWindow(VIS1);
	if (selectionType() != 5) { // 5 corresponds to straight line in ImageJ
		showMessage("Error", "No straight line ROI was drawn on the specified image.");
		exit();
	}
	VIS1x1 = VIS1y1 = VIS1x2 = VIS1y2 = 0; // initialize variables
	VIS1lineWidth = 1; // default value, will be overwritten by getLine()
	getLine(VIS1x1, VIS1y1, VIS1x2, VIS1y2, VIS1lineWidth);

//Draw ROI for VIS2
	// Display instruction for user to draw the ROI
	setTool("line");
	selectImage(VIS2);
	waitForUser("Draw a ROI on the image titled '" + VIS2 + "' and then click OK.");

	// Check if a straight line ROI has been drawn on the specific image
	selectWindow(VIS2);
	if (selectionType() != 5) { // 5 corresponds to straight line in ImageJ
		showMessage("Error", "No straight line ROI was drawn on the specified image.");
		exit();
	}
	VIS2x1 = VIS2y1 = VIS2x2 = VIS2y2 = 0; // initialize variables
	VIS2lineWidth = 1; // default value, will be overwritten by getLine()
	getLine(VIS2x1, VIS2y1, VIS2x2, VIS2y2, VIS2lineWidth);

//Print out the coordinates for debugging
	print("VIS1 Start Point: (" + VIS1x1 + ", " + VIS1y1 + ")");
	print("VIS1 End Point: (" + VIS1x2 + ", " + VIS1y2 + ")");
	print("VIS1 Line Width: " + VIS1lineWidth);
	print("VIS2 Start Point: (" + VIS2x1 + ", " + VIS2y1 + ")");
	print("VIS2 End Point: (" + VIS2x2 + ", " + VIS2y2 + ")");
	print("VIS2 Line Width: " + VIS2lineWidth);

//Make the same ROI selection on the WB image
	selectImage(WB1);
	makeLine(VIS1x1, VIS1y1, VIS1x2, VIS1y2);
	selectImage(WB2);
	makeLine(VIS2x1, VIS2y1, VIS2x2, VIS2y2);

//Print for debugging
	print(WB1);
	print(WB2);

//Align WB2 to WB1
	run("Align Image by line ROI", "source=[" + WB2 + "] target=[" + WB1 + "] scale rotate");
	//Rename the window and synchronize the bitdepth
	newTitle = "WB2_Aligned.TIF";
	rename(newTitle);
	targetBitDepth = WB1_BD;
	if (targetBitDepth == 8) {
		run("8-bit");
	}
	else if (targetBitDepth == 16) {
		run("16-bit");
	}
	else if (targetBitDepth == 32) {
		run("32-bit");
	}
//Merge layers
	run("Merge Channels...");
	run("Invert LUTs");
	
//Merge layers
	//run("Merge Channels...", "c1=WB1.TIF c2=WB2_Aligned.TIF create");
	//run("Invert LUTs");
