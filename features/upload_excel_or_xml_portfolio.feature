Feature: Upload excel or xml format portfolio
	In order to upload excel or xml format portfolio
	As a user
	I want to make sure this function is well
		
	Scenario: Upload excel format portfolio correctly
		Given login the website with 'auto/1' info 
		 When click 'Portfolio Management' link in the menu pane
		  And select the excel/xml file radio button
		  And browse the uploaded file
			|file_path                                   |
			|D:\\template\\path file tem\\Agency Bond.xls|
		  And setup the portfolio name with 'excel_format'
		  And click the upload portfolio button
		 Then uploaded file 'excel_format' will display on the first line of portfolio manager
	
	@test 
	Scenario: do not select the data file
		Given login the website with 'auto/1' info 
		 When click 'Portfolio Management' link in the menu pane
		  And select the excel/xml file radio button
		  And click the upload portfolio button
			Then pop-up prompt message 'Please select an Excel or XML file to upload!'