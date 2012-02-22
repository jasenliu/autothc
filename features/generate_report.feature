Feature: Generate report
	In order to generate report
	As a user
	I want to make sure this function is well
	
	Scenario: Init report data
		Given clear the report list
	
	Scenario Outline: Generate report
		Given login the website with 'auto/1' info
		 When click Generate Reports link in the menu pane
		  And click portfolios radio button
			And select the <portfolio_name> name
			And select the <report_type> type
			And input the <report_name>
			And select the calculation setting
			And set the priority
			And select the report file format
			And click the generate button
		 Then generated <report_name> will display on the first line of view status/report
		 
		Examples:
		| portfolio_name | report_type               | report_name                         |
		| benchmark      | Interest Rate Risk (EVE)  | exl_Interest Rate Risk (EVE)_201109 |
		| benchmark      | Portfolio Analytics       | exl_Portfolio Analytics_201109      |
		
	Scenario: Download report
		Given login the website with 'auto/1' info
		 When click Generate Reports link in the menu pane
			And click View Status/Report tab
		 Then check report process and download the report