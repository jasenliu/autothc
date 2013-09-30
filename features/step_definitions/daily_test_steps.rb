And /^select the portfolio type (.*)$/ do |portfolio_type|
	select_portfolio_file_format(portfolio_type)
	#puts File.dirname(__FILE__)
end

And /^browse the data file (.*)$/ do |data_file|
	browse_data_file(data_file)
end

suf = Time.now.strftime("%Y%m%d%H%M")
And /^setup the portfolio name (.*)$/ do |portfolio_name|
	portfolio_name += suf  # $suf defined in config.rb file
	set_portfolio_name(portfolio_name)
end

Then /^uploaded file (.*) will display on the first line of portfolio manager$/ do |portfolio_name|
	portfolio_name += suf
	show_portfolio(portfolio_name).should == 0
end

And /^select the portfolio name (.*)$/ do |portfolio_name|
  if suf.include?('_')
    suf = suf.gsub(/_/, '')
  end
	portfolio_name += suf
	select_portfolio_by_name(portfolio_name)
end

And /^select the report cycle (\d+)$/ do |report_cycle|
	select_cycle(report_cycle)
end

And /^select the report type (.*)$/ do |report_type|
	select_report(report_type)
end

And /^input the report names (.*?)$/ do |report_name|
  suf = '_' + suf
	report_name += suf
	set_report_name(report_name)
end

Then /^generated report_name (.*?) will display on the first line of view status\/report$/ do |report_name|
	report_name += suf
	show_report(report_name)
end

And /^check the report process and download the report$/ do |table|
  begin_time = Time.now.to_i
  arr = table.hashes
  while(1)
    end_time = Time.now.to_i
    if(end_time - begin_time > 1000)
      puts "time is over"
      break
    end
    
    break if arr.size == 0
    
    arr.each do |hash|
      break if arr.size == 0
      report_name = hash['report_name']
      report_name += suf
      flag = check_report1(report_name)
      hash.delete('report_name') if flag
      arr.delete_if{ |hash| hash.empty? }
    end
  end
end

Then /^compare the daily reports$/ do |table|
  arr = table.hashes
  arr.each do |hash|
    report_name = hash['report_name']
    report_name += suf
    compare_daily_report(report_name)
  end
  p $result_13
end

And /^send the daily test result$/ do
  save_daily_report_result_to_excel
  send_daily_report_result
end
