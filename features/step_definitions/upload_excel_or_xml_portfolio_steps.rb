Given /^login the website with '(.*)\/(.*)' info$/ do |username, passowrd|
	login(username, passowrd, ENV['WEBSITE'])
end

When /^click '(.*)' link in the menu pane$/ do |page_name|
	navigate_to_page(page_name)
end

And /^select the excel\/xml file radio button$/ do
	select_portfolio_file_format('file_excel')
end

And /^browse the uploaded file$/ do |table|
	table.hashes.each do |hash|
		browse_data_file(hash['file_path'])
	end
end

And /^setup the portfolio name with '(.*)'$/ do |name|
	set_portfolio_name(name)
end

And /^click the upload portfolio button$/ do
	click_upload_portfolio_button
end

Then /^uploaded file '(.*)' will display on the first line of portfolio manager$/ do |portfolio_name|
	show_portfolio(portfolio_name).should == 0
end

Then /^pop-up prompt message '(.*)'$/ do |text|
	dialog_text = get_dialog_text
	dialog_text.include?(text).should == true
	click_dialog_ok_button
end