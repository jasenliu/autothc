#include Singleton

=begin
**************************************************************************************
	DefName: open_excel
	Description: open excel
	ParameterList: file_path
								 sheet_name
	Return:

	Author: LiuJingsen
	CreatedDate: 2011-12-12
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-12          LiuJingsen          create 
**************************************************************************************
=end
def open_excel(file_path, sheet_name)
	@excel = WIN32OLE::new('excel.Application')
	@excel.displayalerts = false
	@excel.visible = true
	@excel_file = @excel.workbooks.open(file_path)
	@excel_sheet = @excel_file.worksheets(sheet_name)
end
=begin
**************************************************************************************
	DefName: close_excel
	Description: close excel
	ParameterList: excel_sheet
	Return:

	Author: LiuJingsen
	CreatedDate: 2011-12-12
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-12          LiuJingsen          create
**************************************************************************************
=end
def close_excel
	#excel_sheet.Application.Quit
	#excel_sheet.close
	wmi = WIN32OLE.connect("winmgmts://")
    processes = wmi.ExecQuery("select * from win32_process where
   commandline like '%excel.exe\"% /automation %'")
    for process in processes do
      Process.kill( 'KILL', process.ProcessID.to_i)
    end
end
=begin
**************************************************************************************
	DefName: compare_excel
	Description: compare excel
	ParameterList: generate_excel_path
								 stand_excel_path
								 report_name
	Return:

	Author: LiuJingsen
	CreatedDate: 2011-12-12
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-12          LiuJingsen          create
					2012-01-16          LiuJingsen          add parameter report_name
**************************************************************************************
=end
def compare_excel_sheet(generate_excel_path, stand_excel_path, sheet_name, report_name)
	diff_flag = false
	
	generate_excel_sheet = open_excel(generate_excel_path, sheet_name)
	generate_excel_sheet.activate
	generate_row_count = generate_excel_sheet.UsedRange.rows.count
	generate_column_count = generate_excel_sheet.UsedRange.columns.count
	
	#puts "generate_row_count:" + generate_row_count.to_s
	#puts "generate_column_count:" + generate_column_count.to_s
	
	stand_excel_sheet = open_excel(stand_excel_path, sheet_name)
	stand_excel_sheet.activate
	stand_row_count = stand_excel_sheet.UsedRange.rows.count
	stand_columu_count = stand_excel_sheet.UsedRange.columns.count
	
	#puts "stand_row_count:" + stand_row_count.to_s
	#puts "stand_columu_count:" + stand_columu_count.to_s
	
	if(generate_row_count != stand_row_count || generate_column_count != stand_columu_count)
		diff_flag = true
		excel_name = File.basename(generate_excel_path) 
		msg = "Excel sheet #{excel_name} used ranges are not equal"
	else
		1.upto(generate_row_count) do |row|
			case report_name #remove header and footer of the report
				when "cpr"
					if(row == 5 || row == 6 || row == 26)
						next
					end
				when "dcf"
					if(row == 4 || row == 7 || row == 911)
						next
					end
				when "rmpa"
					if(row == 6 || row == 7 || row == 58)
						next
					end
			end
			1.upto(generate_column_count) do |column|
				tem_generate = generate_excel_sheet.cells(row, column).value.to_s
				tem_stand = stand_excel_sheet.cells(row, column).value.to_s
				if((tem_generate != tem_stand) && ((tem_generate.to_i - tem_stand.to_i).abs > 0.00001))
					diff_flag = true
					msg = "#{report_name} Cell(#{row}, #{column}) values are different: expected_value=#{tem_stand}, actual_value=#{tem_generate}"
					puts msg
					generate_excel_sheet.cells(row, column).value = "Expected:#{tem_stand},Actual:#{tem_generate}"
					generate_excel_sheet.cells(row, column).Font.ColorIndex = 7
					puts "update generate report"
					#generate_excel_path = "D:\\template\\test file\\LoanFileSample.xls"
					#diff_name = File.basename(generate_excel_path, ".xls") + "_diff.xls"
					#diff_path = File.dirname(generate_excel_path) + "\\" + diff_name
					#generate_excel_sheet.saveas(diff_path)
				end
			end
		end
	end

	if(diff_flag)
		diff_name = File.basename(generate_excel_path, ".xls") + "_diff.xls"
		diff_path = File.dirname(generate_excel_path) + "\\" + diff_name
		generate_excel_sheet.saveas(diff_path)
		case ENV['WEBSITE']
				when /13/ then $result_13.store(report_name, "diff")
				when /173/ then $result_173.store(report_name, "diff")
				else $result_thc.store(report_name, "diff")
		end
	else
		case ENV['WEBSITE']
				when /13/ then $result_13.store(report_name, "same")
				when /173/ then $result_173.store(report_name, "same")
				else $result_thc.store(report_name, "same")
		end
	end
	
	close_excel
end