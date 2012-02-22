=begin
**************************************************************************************
	DefName: select_loan_file_type
	Description: select loan file or loan edit
	ParameterList: span_id
								 radio_id			
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-10
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-10          LiuJingsen          create 
**************************************************************************************
=end
def select_loan_file_type(span_id, radio_id)
	@browser.frame(:name, "content").span(:id, span_id).radio(:id, radio_id)
end
=begin
**************************************************************************************
	DefName: set_pricing_date
	Description: set pricing date
	ParameterList: date			
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-10
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-10          LiuJingsen          create 
**************************************************************************************
=end
def set_pricing_date(date)
	@browser.frame(:name, "content").text_field(:id, 'txtDate').set date
end
=begin
**************************************************************************************
	DefName: browse_loan_file_portfolio
	Description: upload loan file portfolio
	ParameterList: file_path			
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-10
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-10          LiuJingsen          create 
**************************************************************************************
=end
def browse_loan_file_portfolio(file_path)
	@browser.frame(:name, "content").file_field(:id, 'loanFile').set file_path
end
=begin
**************************************************************************************
	DefName: click_loan_file_generate_report_button
	Description: click loan file generate report button
	ParameterList: 			
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-10
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-10          LiuJingsen          create 
**************************************************************************************
=end
def click_loan_file_generate_report_button
	@browser.frame(:name, "content").button(:id, 'btnUpload').click
end
=begin
**************************************************************************************
	DefName: loan_file_exist
	Description: verify loan file report whether generate
	ParameterList: loan_file_id
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-10
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-10          LiuJingsen          create 
**************************************************************************************
=end
def loan_file_exist(loan_file_id)
	sleep 1 until !@browser.frame(:name, "content").div(:id, 'popupMask-BODY-').exists?
	div_id = 'loan-' + loan_file_id
	return @browser.frame(:name, "content").div(:id, div_id).exists?
end
=begin
**************************************************************************************
	DefName: get_loan_file_progress
	Description: get loan file progress
	ParameterList: div_index
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-11
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-11          LiuJingsen          create 
**************************************************************************************
=end
def get_loan_file_progress(div_index)
	sleep 1 until @browser.frame(:name, "content").div(:id, 'loanFileList').div(:index, 0).div(:class, 'report').exists?
	progress = ""
	num = 0
	flag = false
	until flag
		num += 1
		begin
			if(@browser.frame(:name, 'content').div(:id, 'loanFileList').div(:index, 0).div(:class, 'report').div(:index, 0).div(:index, div_index).link(:href, /EX_XLS/).exists?)
				progress = "finished"
			else
				progress = @browser.frame(:name, "content").div(:id, 'loanFileList').div(:index, 0).div(:class, 'report').div(:index, 0).div(:index, div_index).span(:id, 'divprogress0').span(:class, 'field-label').text
				if(@browser.frame(:name, "content").div(:id, 'loanFileList').div(:index, 0).div(:class, 'report').div(:index, 0).div(:index, div_index).table(:index, 0).exists?)
					progress += @browser.frame(:name, "content").div(:id, 'loanFileList').div(:index, 0).div(:class, 'report').div(:index, 0).div(:index, div_index).table(:index, 0)[0][1].text
				end
			end
			flag = true
			rescue => e
				#puts e
				flag = false
			ensure
				flag = true if num > 10
		end
	end
	return progress
end
=begin
**************************************************************************************
	DefName: check_loan_file_progress
	Description: check loan file progress
	ParameterList: 
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-11
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-11          LiuJingsen          create 
**************************************************************************************
=end
def check_loan_file_progress(hash_filepath)
	@browser.wait
	begin_time = Time.now.to_i
	while(1 == 1)
		if(Time.now.to_i - begin_time > 300)
			puts 'time out'
			break
		end
		if(hash_filepath.size == 0)
			break
		end
		
		hash_filepath.each do |name, file_path|
			  div_index = case name
					when "cpr" then 0
					when "dcf" then 1
					else 2
				end
				progress = get_loan_file_progress(div_index)
				#puts "get progress:" + progress
				if(progress == 'finished')
					download_loan_file_report(hash_filepath[name], div_index)
					hash_filepath.delete(name)
					#puts "delete #{name} report"
				elsif(progress.include?('Report Error'))
					puts name + 'progress: ' + progress
					hash_filepath.delete(name)
				else
					#puts name + ' progress: ' + progress 
				end
		end
	end
	close_ie_process
end
=begin
**************************************************************************************
	DefName: download_loan_file_report
	Description: download loan file report
	ParameterList: file_path
								 index
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-12
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-12          LiuJingsen          create 
**************************************************************************************
=end
def download_loan_file_report(file_path, div_index)
	num = 0
	flag = false
	until flag
		num += 1
		begin
			@browser.frame(:name, 'content').div(:id, 'loanFileList').div(:index, 0).div(:class, 'report').div(:index, 0).div(:index, div_index).link(:href, /EX_XLS/).left_click
			flag = true
			rescue => e
				#puts e
				flag = false
			ensure
				flag = true if num > 10
		end
	end
	
	sleep 2
	save_file(file_path)
	@browser.bring_to_front
end
=begin
**************************************************************************************
	DefName: compare_loan_file_report
	Description: compare loan file report
	ParameterList:
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-16
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-16          LiuJingsen          create 
**************************************************************************************
=end
def compare_loan_file_report
	#puts "begin to compare loan file report"
	$result = {}
	$compare_filepath.each do |report_name, file_path|
		#puts "file_path:" + file_path
		if(File.exists?(file_path))
			#puts "compare #{report_name} loan file report..."
			stand_excel_path = case report_name
				when "cpr" then "D:\\work\\thc\\lib\\report\\std report\\cpr_std.xls"
				when "dcf" then "D:\\work\\thc\\lib\\report\\std report\\dcf_std.xls"
				else "D:\\work\\thc\\lib\\report\\std report\\rmpa_std.xls"
			end
			#puts "name:" + report_name
			compare_excel_sheet(file_path, stand_excel_path, "Sheet1", report_name)
			#puts "compare #{report_name} loan file report finished"
		else
			puts "#{report_name} report generate failed"
			$result.store(report_name, "no report")
		end
	end
end
=begin
**************************************************************************************
	DefName: get_analysis_table_data_from_page
	Description: get analysis table data from page
	ParameterList:
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-17
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-17          LiuJingsen          create 
**************************************************************************************
=end
def get_analysis_table_data_from_page
	sleep 1 until @browser.frame(:name, "content").div(:id, 'loanFileList').div(:index, 0).div(:class, 'preview').exists?
	table = @browser.frame(:name, "content").div(:id, 'loanFileList').div(:index, 0).div(:class, 'preview').table(:index, 0)
	arr = []
	for i in 3..8
		tem_arr = []
		table[i].each do |cell|
			if(cell.text == 'WL' || cell.text == 'MBS')
				next
			end
			tem_arr << cell.text
		end
		arr << tem_arr
	end
	return arr
end
=begin
**************************************************************************************
	DefName: get_analysis_table_data_from_excel
	Description: get analysis table data from excel and compare the data
	ParameterList: arr_page
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-17
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-17          LiuJingsen          create 
**************************************************************************************
=end
def get_analysis_table_data_from_excel(arr_page)
	diff_flag = false
	if(File.exists?($compare_filepath['rmpa']))
		excel = open_excel($compare_filepath['rmpa'], 'Sheet1')
		excel.activate
		excel_column_count = excel.UsedRange.columns.count
		for row in 17..26
			if(row == 21 || row == 22 || row == 23 || row == 24) #remoe the item which don't require
				next
			end
			2.upto(excel_column_count + 1) do |column|
				if(column == 9 || column == 10 || column == 12 || column == 13 || column == 14)
					next
				end
				
				i = row
				if(row > 24)
					i = row - 21
				else
					i = row - 17
				end
				
				j = column
				if(column == 11)
					j = column - 4
				elsif(column > 14)
					j = column - 7
				else
					j = column - 2
				end
				
				tem_page = arr_page[i][j]
				if(tem_page.include?(","))
					tem_page = tem_page.gsub(/,/, '')
				end
				tem_excel = excel.cells(row, column).value.to_s
				if((tem_page != tem_excel) && ((tem_page.to_i - tem_excel.to_i).abs > 0.00001))
					diff_flag = true
					msg = "Cell(#{row}, #{column}) values are different: expected_value=#{tem_excel}, actual_value=#{tem_page}"
					puts msg
					excel.cells(row, column).value = "Expected:#{tem_excel},Actual:#{tem_page}"
					excel.cells(row, column).Font.ColorIndex = 7
				end
			end
		end
		if(diff_flag)
			diff_name = File.basename($compare_filepath['rmpa'], ".xls") + "_page_diff.xls"
			diff_path = File.dirname($compare_filepath['rmpa']) + "\\" + diff_name
			excel.saveas(diff_path)
			$result.store("at", "diff") #at means Analysis Table on the loan file page
		else
			$result.store("at", "same")
		end
	else
		puts "rmpa report do not exists"
		$result.store("at", "no report")
	end
	close_excel
end
=begin
**************************************************************************************
	DefName: send_loan_file_result
	Description: send loan file result
	ParameterList: 
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-19
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-19          LiuJingsen          create 
**************************************************************************************
=end
def send_loan_file_result
	$result.each do |name, result|
		if(result == "same")
			$result[name] = "<td style='color:green'>#{result}</td>"
		else
			$result[name] = "<td style='color:red'>#{result}</td>"
		end
	end
	html = <<html_end
	<html>
		<body>
			The following is the result:
			<table border="1" cellspacing="1" cellpadding="1">
				<tr>
					<td>Report</td>
					<td>WEB13</td>
				</tr>
				<tr>
					<td>CPR Yield Table</td>
					#{$result["cpr"]}
				</tr>
				<tr>
					<td>Decrement Cash Flow</td>
					#{$result["dcf"]}
				</tr>
				<tr>
					<td>Residential Mortgage Profitability Analysis</td>
					#{$result["rmpa"]}
				</tr>
				<tr>
					<td>Analysis Table</td>
					#{$result["at"]}
				</tr>
			</table>
			<a href='file:///\\192.168.0.17\\thc\\report.html'>report.html</a>
		</body>
	</html>
html_end
	send_email('QA@thc.net.cn', 'only for test', html)
end


