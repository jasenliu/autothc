When /^click Loan File link in the menu pane$/ do
	navigate_to_page('Loan File')
end

And /click loan file radio button/ do
	select_loan_file_type('spnLoanFile', 'inputLoanFile')
end

And /^select the bank$/ do
	
end

And /^setup the pricing date$/ do
	set_pricing_date(PRICING_DATE)
end

And /^browse the loan file portfolio$/ do |table|
	table.hashes.each do |hash|
		browse_loan_file_portfolio(hash['file_path'])
	end
end

And /^click the generate reports button$/ do
	click_loan_file_generate_report_button
end

Then /^the repot will displayed on the report table$/ do
	sleep 2
	loan_file_id = get_max_loan_file_id(DB13HOST, DB13USER, DB13PASSWORD)
	loan_file_exist(loan_file_id).should == true
end

Then /^check the loanfile progress and download the report$/ do
	pre = Time.now.to_i
	hash_filepath = {
		'cpr' => "D:\\work\\thc\\lib\\report\\#{pre}_cpr.xls",
		'dcf' => "D:\\work\\thc\\lib\\report\\#{pre}_dcf.xls",
		'rmpa' => "D:\\work\\thc\\lib\\report\\#{pre}_rmpa.xls"
	}
	$compare_filepath = {
		'cpr' => "D:\\work\\thc\\lib\\report\\#{pre}_cpr.xls",
		'dcf' => "D:\\work\\thc\\lib\\report\\#{pre}_dcf.xls",
		'rmpa' => "D:\\work\\thc\\lib\\report\\#{pre}_rmpa.xls"
	}
	#puts "$compare_filepath:"
	#puts $compare_filepath
	check_loan_file_progress(hash_filepath)
end

When /^get the loan file report and compare them$/ do
	compare_loan_file_report
end

And /^get the analysis table data from loan file page$/ do
	@arr_page = get_analysis_table_data_from_page
end

Then /^get the rmpa report data from excel and compare them$/ do
	get_analysis_table_data_from_excel(@arr_page)
end

Given /^send the loan file result$/ do
	send_loan_file_result
end