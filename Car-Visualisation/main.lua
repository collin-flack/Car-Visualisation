-- Built on: iPhone 5 
-- Collin Flack
-- CS 371-01
-- 28 October 2020 

local json = require("json");
local csv = require("csv");
local widget = require("widget"); 
local csv_path = system.pathForFile('car.csv');
local cars = {}; 
local f = csv.open(csv_path);
display.setDefault( "background", 1, 1, 1 );

local sliderText = display.newText("1800", display.contentCenterX - 50, display.contentCenterY + 150, native.systemFont, 15);
local sliderText2 = display.newText("4000", display.contentCenterX - 50, display.contentCenterY + 250, native.systemFont, 15);
sliderText:setFillColor(0, 0, 0); 
sliderText2:setFillColor(0, 0, 0); 

local sliderGroup = display.newGroup(); 

math.randomseed(os.time()); 

weightIsOn = true;
mileageIsOn = false; 

maxValue = 100;
minValue = 0; 

firstLine = true;
smallBool = false; 
compactBool = false; 
sportyBool = false; 
largeBool = false; 
vanBool = false; 
mediumBool = false;  

function createCars()

	for fields in f:lines() do 

		local function createBall(fields)

			local xVal = math.random(1, 9); 
			local yVal = math.random(1, 9);
			local weight = tonumber(fields[2]) / 150; 

			xVal = xVal / 10;
			yVal = yVal / 10;

			xVal = xVal * display.contentWidth;
			yVal = yVal * display.contentHeight/2;  

			local text = display.newText(fields[1], xVal, yVal, native.systemFont, 15);
			text:setFillColor(0, 0, 0); 

			local ball = display.newCircle(xVal, yVal, weight )

			local car = display.newGroup(); 

			ball:toBack(); 

			car:insert(ball); 
			car:insert(text);
			car.ballRadius = weight; 
			car.name = fields[1];
			car.weight = weight
			car.mileage = tonumber(fields[4]);
			car.mileageD = car.mileage / 20;  
			car.deltaX = car.mileageD; 
			car.deltaY = car.mileageD;
			car.type = fields[6];

			if car.type == "Small" then

	 			ball:setFillColor(0, 0.337, 0); 

			end

			if car.type == "Sporty" then

	 			ball:setFillColor(0.8, 0, 0.4); 

			end

			if car.type == "Compact" then

	 			ball:setFillColor(0.4, 0.4, 1); 

			end

			if car.type == "Medium" then

	 			ball:setFillColor(0.5, 0.5, 0.5); 

			end

			if car.type == "Large" then

	 			ball:setFillColor(0.8, 0, 0); 

			end

			if car.type == "Van" then

	 			ball:setFillColor(1, 1, 0.5); 

			end

			table.insert(cars, car); 

		end

		if firstLine == false  then 

			local circle = createBall(fields); 

		end 

		if (firstLine) then 

			firstLine = false; 

		end	


	end

end 

function update()

	for _, ball in ipairs(cars) do -- The _ returns the index, but in this example no index needed so "_"


		if not ball[1].stopped and ball[1].x ~= nill then 
			if ball[1].x + ball.deltaX > display.contentWidth - ball.ballRadius or ball[1].x + ball.deltaX < ball.ballRadius then 
				ball.deltaX = -ball.deltaX
			end

			if ball[1].y + ball.deltaY > display.contentHeight/2 - ball.ballRadius  or ball[1].y + ball.deltaY < 50 then 
				ball.deltaY = -ball.deltaY
			end

			ball[1].x = ball[1].x + ball.deltaX 
			ball[1].y = ball[1].y + ball.deltaY 

			ball[2].x = ball[2].x + ball.deltaX 
			ball[2].y = ball[2].y + ball.deltaY 

		end 

	end 

end

function weightState()

	if (smallBool == true and mediumBool == true and largeBool == true and sportyBool == true and compactBool == true and vanBool == true) or
	   (smallBool == false and mediumBool == false and largeBool == false and sportyBool == false and compactBool == false and vanBool == false) then

		--print("All cars are currently showing");

		for _, car in ipairs(cars) do

			if car.weight > minValue and car.weight < maxValue then 
			
				car.isVisible = true; 

			else

				car.isVisible = false; 

			end

		end

	else

		for _, car in ipairs(cars) do

			car.isVisible = false; 

			if smallBool == true and car.type == "Small" and car.weight > minValue and car.weight < maxValue then 

				car.isVisible = true; 

			elseif sportyBool == true and car.type == "Sporty" and car.weight > minValue and car.weight < maxValue then

				car.isVisible = true; 

			elseif compactBool == true and car.type == "Compact" and car.weight > minValue and car.weight < maxValue then

				car.isVisible = true; 
			
			elseif mediumBool == true and car.type == "Medium" and car.weight > minValue and car.weight < maxValue then

				car.isVisible = true; 
			
			elseif largeBool == true and car.type == "Large" and car.weight > minValue and car.weight < maxValue then

				car.isVisible = true; 

			elseif vanBool == true and car.type == "Van" and car.weight > minValue and car.weight < maxValue then

				car.isVisible = true; 

			end

		end



	end

end

function mileageState() 

	if (smallBool == true and mediumBool == true and largeBool == true and sportyBool == true and compactBool == true and vanBool == true) or
	   (smallBool == false and mediumBool == false and largeBool == false and sportyBool == false and compactBool == false and vanBool == false) then

		for _, car in ipairs(cars) do

			if car.mileage > minValue and car.mileage < maxValue then 

				car.isVisible = true; 

			else

				car.isVisible = false;

			end 

		end

	else

		for _, car in ipairs(cars) do

			car.isVisible = false; 

			if smallBool == true and car.type == "Small" and car.mileage > minValue and car.mileage < maxValue then 

				car.isVisible = true; 

			elseif sportyBool == true and car.type == "Sporty" and car.mileage > minValue and car.mileage < maxValue then

				car.isVisible = true; 

			elseif compactBool == true and car.type == "Compact" and car.mileage > minValue and car.mileage < maxValue then

				car.isVisible = true; 
			
			elseif mediumBool == true and car.type == "Medium" and car.mileage > minValue and car.mileage < maxValue then

				car.isVisible = true; 
			
			elseif largeBool == true and car.type == "Large" and car.mileage > minValue and car.mileage < maxValue then

				car.isVisible = true; 

			elseif vanBool == true and car.type == "Van" and car.mileage > minValue and car.mileage < maxValue then

				car.isVisible = true; 

			end

		end



	end

end

function updateQuick() 

	if weightIsOn then 

		weightState(); 

	elseif mileageIsOn then

		mileageState(); 

	else 

		print("Error"); 


	end 

end

function onSwitchPress() 

	smallBool = not smallBool; 
	print(smallBool); 
	print("Small")

end 

function onSwitchPress2() 

	sportyBool = not sportyBool; 
	print("Sporty");

end 

function onSwitchPress3() 

	compactBool = not compactBool; 
	print("Compact"); 

end 

function onSwitchPress4() 

	mediumBool = not mediumBool; 
	print("Medium");

end 

function onSwitchPress5() 

	largeBool = not largeBool; 
	print("Large");

end 

function onSwitchPress6() 

	vanBool = not vanBool; 
	print("Van"); 

end 

function createCheckBoxes() 

	local boxGroup = display.newGroup(); 

		local opt = {

			frames = {

				{ x = 314, y = 0, width = 273, height = 233},
	       		{ x = 314, y = 279, width = 233, height = 233}

			}

		}

	local checkboxSheet = graphics.newImageSheet( "checkboxSheet.png", opt ) 

	local checkbox = widget.newSwitch(
		{
			x = display.contentCenterX,
			y = display.contentCenterY + 50,
			style = "checkbox",
			id = "Checkbox",
			width = 20,
			height = 20,
			onPress = onSwitchPress, 
			sheet = checkboxSheet, 
			frameOff = 2,
			frameOn = 1
		}
		); 
	local checktext = display.newText("Small", checkbox.x + 30, checkbox.y, native.systemFont, 10);
	checktext:setFillColor(0, 0, 0); 

	local checkbox2 = widget.newSwitch(
		{
			x = display.contentCenterX,
			y = display.contentCenterY + 80,
			style = "checkbox",
			id = "Checkbox",
			width = 20,
			height = 20,
			onPress = onSwitchPress2, 
			sheet = checkboxSheet, 
			frameOff = 2,
			frameOn = 1
		}
		); 
	local checktext2 = display.newText("Sporty", checkbox2.x + 30, checkbox2.y, native.systemFont, 10);
	checktext2:setFillColor(0, 0, 0); 

	local checkbox3 = widget.newSwitch(
		{
			x = display.contentCenterX,
			y = display.contentCenterY + 110,
			style = "checkbox",
			id = "Checkbox",
			width = 20,
			height = 20,
			onPress = onSwitchPress3, 
			sheet = checkboxSheet, 
			frameOff = 2,
			frameOn = 1
		}
		); 
	local checktext3 = display.newText("Compact", checkbox3.x + 35, checkbox3.y, native.systemFont, 10);
	checktext3:setFillColor(0, 0, 0); 

	local checkbox4 = widget.newSwitch(
		{
			x = display.contentCenterX,
			y = display.contentCenterY + 140,
			style = "checkbox",
			id = "Checkbox",
			width = 20,
			height = 20,
			onPress = onSwitchPress4, 
			sheet = checkboxSheet, 
			frameOff = 2,
			frameOn = 1
		}
		); 
	local checktext4 = display.newText("Medium", checkbox4.x + 35, checkbox4.y, native.systemFont, 10);
	checktext4:setFillColor(0, 0, 0); 	

	local checkbox5 = widget.newSwitch(
		{
			x = display.contentCenterX,
			y = display.contentCenterY + 170,
			style = "checkbox",
			id = "Checkbox",
			width = 20,
			height = 20,
			onPress = onSwitchPress5, 
			sheet = checkboxSheet, 
			frameOff = 2,
			frameOn = 1
		}
		); 
	local checktext5 = display.newText("Large", checkbox5.x + 35, checkbox5.y, native.systemFont, 10);
	checktext5:setFillColor(0, 0, 0); 	

	local checkbox6 = widget.newSwitch(
		{
			x = display.contentCenterX,
			y = display.contentCenterY + 200,
			style = "checkbox",
			id = "Checkbox",
			width = 20,
			height = 20,
			onPress = onSwitchPress6, 
			sheet = checkboxSheet, 
			frameOff = 2,
			frameOn = 1
		}
		); 
	local checktext6 = display.newText("Van", checkbox6.x + 30, checkbox6.y, native.systemFont, 10);
	checktext6:setFillColor(0, 0, 0); 	

	boxGroup:insert(checkbox); 
	boxGroup:insert(checkbox2); 
	boxGroup:insert(checkbox3); 
	boxGroup:insert(checkbox4); 
	boxGroup:insert(checkbox5); 
	boxGroup:insert(checkbox6); 

	boxGroup:insert(checktext);
	boxGroup:insert(checktext2);  
	boxGroup:insert(checktext3);
	boxGroup:insert(checktext4); 
	boxGroup:insert(checktext5); 
	boxGroup:insert(checktext6); 

	boxGroup.x = boxGroup.x - 125; 
	boxGroup.y = boxGroup.y + 50;

end	

function onSwitchPressRadio()

	if not weightIsOn and mileageIsOn then 

		weightIsOn = true; 
		mileageIsOn = false; 
		sliderText.text = "1800";
		sliderText2.text = "4000"; 
		minValue = 1800 / 150;
		maxValue = 4000 / 150; 
		--sliderGroup[1].value = 1800; 
		--sliderGroup[2].value = 4000; 

	end 

end

function onSwitchPressRadio2()

	if not mileageIsOn and weightIsOn then 
	
		mileageIsOn = true; 
		weightIsOn = false;
		sliderText.text = "10";
		sliderText2.text = "50";
		minValue = 10; 
		maxValue = 50; 
		--sliderGroup[1].value = 10; 
		--sliderGroup[2].value = 50; 


	end 

end

function createRadioButtons() 

	local radioGroup = display.newGroup(); 

	opt1 = 

		{

		x = display.contentCenterX,
		y = display.contentCenterY + 100, 
		style = "radio",
		id = "weightButton", 
		initialSwitchState = true, 
		onPress = onSwitchPressRadio
		
		}

	opt2 = 

		{

		x = display.contentCenterX + 100,
		y = display.contentCenterY + 100, 
		style = "radio",
		id = "mileageButton", 
		initialSwitchState = false, 
		onPress = onSwitchPressRadio2
		
		}

	local weightButton = widget.newSwitch(opt1);
	local mileageButton = widget.newSwitch(opt2);

	local wtext = display.newText("Weight", display.contentCenterX, display.contentCenterY + 125, native.systemFont, 15);
	local mtext = display.newText("Mileage", display.contentCenterX + 100, display.contentCenterY + 125, native.systemFont, 15);

	wtext:setFillColor(0, 0, 0); 
	mtext:setFillColor(0, 0, 0);

	local function sliderListener( event )

		local conversion = event.value; 

		if weightIsOn then

			conversion = ( conversion * 22 ) + 1800;

		elseif mileageIsOn then

			conversion = (conversion / 2.5) + 10; 

		end 

		sliderText.text = tostring(conversion);
		minValue = conversion; 

		if weightIsOn then

			conversion = conversion / 150;
			minValue = conversion; 

		end 		

	
	end

	local function sliderListener2( event )


		local conversion = event.value; 

		if weightIsOn then

			conversion = ( conversion * 22 ) + 1800;

		elseif mileageIsOn then

			conversion = (conversion / 2.5) + 10; 

		end

		sliderText2.text = tostring(conversion);
		maxValue = conversion; 

		if weightIsOn then

			conversion = conversion / 150;
			maxValue = conversion; 

		end 
	
	end

	opt3 = 

		{

		y = display.contentCenterY + 150,
		x = display.contentCenterX + 50,
		width = 150,
		value = 0, 
		listener = sliderListener,

	} 

	opt4 = 

	{

	y = display.contentCenterY + 250,
	x = display.contentCenterX + 50,
	width = 150,
	value = 100, 
	listener = sliderListener2,

	} 

	sliderMin = widget.newSlider(opt3);
	sliderMax = widget.newSlider(opt4); 

	radioGroup:insert(weightButton); 
	radioGroup:insert(mileageButton); 

	sliderGroup:insert(sliderMin); 
	sliderGroup:insert(sliderMax); 

end

createCars(); 
createCheckBoxes();
createRadioButtons(); 

time = timer.performWithDelay(  30, update, 0);
time = timer.performWithDelay(  15, updateQuick, 0);