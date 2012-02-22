Feature: Generate loan file report
	In order to generate loanfile report
	As a user
	I want to make sure this function is well
	
	@test
	Scenario: Generate loanfile report correctly
		Given login the website with 'auto/1' info 
		 When click Loan File link in the menu pane
		  And click loan file radio button
			And select the bank
			And setup the pricing date
			And browse the loan file portfolio
			|file_path                                                   |
			|D:\\work\\thc\\lib\\data file\\excel xml\\LoanFileSample.xls|
		  And click the generate reports button
		 Then the repot will displayed on the report table
		 
	Scenario: Download loanfile report
		Given login the website with 'auto/1' info 
		 When click Loan File link in the menu pane
		 Then check the loanfile progress and download the report
		 
	Scenario: Compare loan file report
		 When get the loan file report and compare them
		 
	Scenario: Compare analysis table data
		 Given login the website with 'auto/1' info 
		 When click Loan File link in the menu pane
			And get the analysis table data from loan file page
			Then get the rmpa report data from excel and compare them
		 
	Scenario: send the loan file result
		 Given send the loan file result