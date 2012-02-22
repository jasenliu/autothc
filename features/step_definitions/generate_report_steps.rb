=begin
Given /^login the web13 with '(.*)\/(.*)' info$/ do |username, password|
	#login(username, password)
end
=end
Given /^clear the report list$/ do
	clear_report_list(DB13HOST,DB13USER,DB13PASSWORD)
end

When /^click Generate Reports link in the menu pane$/ do
	navigate_to_page('Generate Reports')
	sleep 2
	click_tab_by_name('Generate Report')
end

And /^click portfolios radio button$/ do
	select_portfolio_type('selectPortfolio')
end

And /^select the (.*) name$/ do |portfolio_name|
	select_portfolio_by_name(portfolio_name)
end

And /^select the (.*) type$/ do |report_type|
	select_report(report_type)
end

And /^input the (.*)$/ do |report_name|
	set_report_name(report_name)
end

And /^select the calculation setting$/ do
	calculation_setting
end

And /^set the priority$/ do
	set_priority
end

And /^select the report file format$/ do 
	set_report_format
end

And /^click the generate button$/ do
	click_generate_button
end

Then /^generated (.*) will display on the first line of view status\/report$/ do |report_name|
	show_report(report_name)
	report_hash = {
	"R111226-1-1" => "d:\\R111226-1-1.xls",
	"R111223-7-1" => "d:\\R111223-7-1.xls",
	"EAR-1" => "d:\\EAR.xls"
}
	#check_report(report_hash)
	#download_report('IRR111222', 'd:\\report.xls')
	#3sleep 3
	#view_report('IRR111222-1')
	#sleep 15
	#get_progress.should == 1
end

And /^click View Status\/Report tab$/ do
	click_tab_by_name('View Status/ Report')
end

Then /^check report process and download the report$/ do
	report_hash = {
	"exl_Interest Rate Risk (EVE)_201109-1" => "d:\\exl_Interest Rate Risk (EVE)_201109-1.xls",
	"exl_Portfolio Analytics_201109-1" => "d:\\exl_Portfolio Analytics_201109-1.xls"
}
	check_report(report_hash)
end