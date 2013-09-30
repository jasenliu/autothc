Feature: Compare commonly used reports
	In order to make sure common reports can works ok
	As a user
	I want to major reports can generated successfully
		
  @test
	Scenario Outline: Upload portfolio correctly
		Given login the website with 'auto/1' info 
		 When click 'Portfolio Management' link in the menu pane
		  And select the portfolio type <portfolio_type>
		  And browse the data file <data_file>
		  And setup the portfolio name <portfolio_name>
		  And click the upload portfolio button
		 Then uploaded file <portfolio_name> will display on the first line of portfolio manager
		 
		 Examples:
		|portfolio_type|data_file                                                    |portfolio_name|
		|file_excel    |D:\\AutoThc\\lib\\data file\\excel xml\\Agency Bond_min.xls  |xls_portfolio |
		
	Scenario Outline: Generate report
		Given login the website with 'auto/1' info
		 When click Generate Reports link in the menu pane
		  And click portfolios radio button
		  And select the portfolio name <portfolio_name>
		  And select the report cycle <report_cycle>
		  And select the report type <report_type>
		  And input the report names <report_names>
		  And select the calculation setting
		  And set the priority
		  And select the report file format
		  And click the generate button
		  Then generated report_name <report_names> will display on the first line of view status/report
		 
		Examples:
		| portfolio_name | report_cycle | report_type               | report_names                          |
		| xls_portfolio  | 201306       | Interest Rate Risk (EVE)  | exl_Interest Rate Risk (EVE)_201306   |
		| xls_portfolio  | 201306       | Portfolio Analytics       | exl_Portfolio Analytics_201306        |
    
		
Scenario: Download report
		Given login the website with 'auto/1' info
		 When click Generate Reports link in the menu pane
		  And click View Status/Report tab
		  And check the report process and download the report
		 | report_name                         |
		 | exl_Interest Rate Risk (EVE)_201306 |
		 | exl_Portfolio Analytics_201306      |
		 Then compare the daily reports
		 | report_name                         |
		 | exl_Interest Rate Risk (EVE)_201306 |
		 | exl_Portfolio Analytics_201306      |
         And send the daily test result
