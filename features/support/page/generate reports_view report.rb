=begin
**************************************************************************************
	DefName: set_report_format
	Description: set report format
	ParameterList: checkbox_id
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-19
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-19         LiuJingsen          create 
**************************************************************************************
=end
def view_report(report_name)
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist').link(:text, report_name).fire_event("onmouseup")
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'popup-menu-container').link(:text, 'View Report Setting').click
	#table = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist')
=begin
	for i in 1..table.row_count
		row = table[i]
		if(row.attribute_value('rp_name') == report_name)
			id = row.attribute_value('rp_id')
			sleep 2
			#url = row[2].link(:href, /XLS/).href
			save_file(file_path)
			#puts url
			#puts Watir::IE.attach(:url, url).exists?
			#close_ie_process
			#@browser.close_others
			break
		end
	end
=end
end
=begin
**************************************************************************************
	DefName: get_progress
	Description: get progress
	ParameterList:
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-21
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-21         LiuJingsen          create 
**************************************************************************************
=end
def get_progress
	begin_time = Time.now.to_i
  num = 0
  flag = false
  until flag
   num += 1
   begin
      ie = Watir::IE.attach(:title, 'Report Setting')
      cell = ie.table(:index, 0).[](2).[](1)
      span = ie.span(:id, 'divprogress0').span(:class, 'field-label')
      error = ie.table(:index, 1)[0][1]
      error1 = ie.span(:id, 'divReset')
      if(span.exists?)
        progress = span.text
        if(error.exists?)
          progress += error.text
        end
        if(error1.exists?)
          progress += error1.text
        end
      else
        progress = cell.text
      end
      ie.close
   rescue => e
     flag = false
   ensure
     flag = true if num > 30
   end 
  end
	return progress
=begin
	while(1 == 1)
    sleep 1 until Watir::IE.attach(:title, 'Report Setting').exists?
		if(Watir::IE.attach(:title, 'Report Setting').exists?)
			break
		end
		if(Time.now.to_i - begin_time > 120)
			break
		end
	end
	ie = Watir::IE.attach(:title, 'Report Setting')
	cell = ie.table(:index, 0).[](2).[](1)
	span = ie.span(:id, 'divprogress0').span(:class, 'field-label')
	error = ie.table(:index, 1)[0][1]
	error1 = ie.span(:id, 'divReset')
	if(span.exists?)
		progress = span.text
		if(error.exists?)
			progress += error.text
		end
		if(error1.exists?)
			progress += error1.text
		end
	else
		progress = cell.text
	end
	ie.close
	return progress
=end
end
=begin
**************************************************************************************
	DefName: show_report
	Description: verify the generated report whether display on the report list
	ParameterList: report_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-22
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-22         LiuJingsen          create 
**************************************************************************************
=end
def show_report(report_name)
	#sleep 5
	#report_name += '-1'
	sleep 1 until @browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'tabArea').span(:index, '1').class_name == 'tab activeTab'
	report_cell = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist')[1][1].text
	report_cell.should == report_name
end
=begin
**************************************************************************************
	DefName: download_report
	Description: download report from the system
	ParameterList: report_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-23
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-23         LiuJingsen          create 
**************************************************************************************
=end
def download_report(report_name, file_path)
	#report_name += '-1'
	#@browser.refresh
	click_tab_by_name('View Status/ Report')
  sleep 2
	table = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist')
	for i in 1..table.row_count
		row = table[i]
		if(row.attribute_value('rp_name') == report_name)
			row[2].link(:href, /XLS/).click_no_wait
			sleep 2
			#url = row[2].link(:href, /XLS/).href
			save_file(file_path)
			#puts url
			#puts Watir::IE.attach(:url, url).exists?
			#close_ie_process
			#@browser.close_others
			break
		end
	end
end

def download_report1(file_path, index)
	click_tab_by_name('View Status/ Report')
  sleep 2
  table = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist')
  row = table[index]
  row[2].link(:href, /XLS/).click_no_wait
  sleep 2
  save_file(file_path)
end
=begin
**************************************************************************************
	DefName: save_file
	Description: save report file
	ParameterList: report_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-23
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-23         LiuJingsen          create 
**************************************************************************************
=end
def save_file(file_path)
    ai = WIN32OLE.new("AutoItX3.Control")
    ai.WinWait("File Download", "", 5)
    ai.ControlFocus("File Download", "", "&Save")
    sleep 1
    ai.ControlClick("File Download", "", "&Save", "left")
    ai.WinWait("Save As", "", 5)
    sleep 1
    ai.ControlSend("Save As", "", "Edit1",file_path)
    ai.ControlClick("Save As", "", "&Save", "left")
    ai.WinWait("Download complete", "", 5)
    ai.ControlClick("Download complete", "", "Close")
end
=begin
**************************************************************************************
	DefName: check_report
	Description: check the report whether finish
	ParameterList:
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-26
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-26        LiuJingsen          create 
**************************************************************************************
=end
def check_report(report_hash)
	sleep 1 until @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist').exists?
	table = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist')
	#report_hash = {}
	begin_time = Time.now.to_i
	end_time = Time.now.to_i
	while(1 == 1)
		if(report_hash.size == 0) 
			break
		end
		
		end_time = Time.now.to_i
		if(end_time - begin_time > 150)
			puts "time is over"
			break
		end
		
		for i in 1..(table.row_count - 1)
			page_report_name = table[i][1].text
			report_hash.each do |report_name, file_path|
				if(page_report_name == report_name)
					view_report(report_name)
					progress = get_progress
					if(progress == 'Finished')
						download_report(report_name, file_path)
						report_hash.delete(report_name)
					elsif(progress.include?('Report Error'))
						puts report_name + ' progress:' + progress
						report_hash.delete(report_name)
					else
						puts report_name + ' progress:' + progress
					end
				end
			end
		end
	end
	#close_ie_process
end

def check_report1(report_name)
  flag = false
	sleep 1 until @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist').exists?
	table = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_reportlist')
	#while(1)
		for i in 1..(table.row_count - 1)
			page_report_name = table[i][1].text
			row = table[i]
			if(page_report_name == report_name)
				view_report(report_name)
				progress = get_progress
				if(progress == 'Finished')
					file_path = GENERATE_REPORT_PATH + Time.now.strftime('%Y%m%d').to_s + '/Web13/' + report_name
					file_path = file_path.gsub(/\//, "\\\\")#for win7 64 bit
					#download_report1(file_path, i)
					download_report(report_name, file_path)
					flag = true
          break
				elsif(progress.include?('Report Error'))
					puts report_name + ' progress:' + progress
          flag = true
          break
        else
				  puts report_name + ' progress:' + progress
          flag = false
          break
        end
      end
		end
	#end
  flag
	#close_ie_process
end

def compare_daily_report(report_name)
  generate_file_path = GENERATE_REPORT_PATH + Time.now.strftime('%Y%m%d').to_s + '/Web13/' + report_name + '.xls'
  generate_file_path = generate_file_path.gsub(/\//, "\\\\")#for win7 64 bit
  arr_report = report_name.split('_')
  standard_file_path = STANDARD_REPORT_PATH + arr_report[0] + '/Web13/' + arr_report[2] + '/' + arr_report[1] + '.xls'
  standard_file_path = standard_file_path.gsub(/\//, "\\\\")
  if(File.exists?(generate_file_path))
    arr_sheet = get_sheet_names(generate_file_path)
    arr_sheet.each do |sheet_name|
      compare_common_sheet(generate_file_path, standard_file_path, sheet_name, report_name)
    end
  else
    puts "#{report_name} generate failed"
    $result_13.store(arr_report[1], "no report")
  end
end

def save_daily_report_result_to_excel
  result_path = RESULT_REPORT_PATH + Time.now.strftime('%Y%m%d') + '/TestResult.xls'
  result_path = result_path.gsub(/\//, "\\\\")
  excel = open_excel(result_path, 'Sheet1')
  excel.activate
  i = 1
  $result_13.each do |key, value|
    i += 1
    excel.cells(i, 1).value = key
    excel.cells(i, 2).value = value
  end
  excel.saveas(result_path)
  close_excel
end

def send_daily_report_result
  html = <<html_end
	<html>
		<body>
			The following is the result:
			<table border="1" cellspacing="1" cellpadding="1">
				<tr>
					<td>Report</td>
					<td>WEB13</td>
				</tr>
          <% $result_13.each do |key, value| %>
            <tr>
              <td><%= key %></td>
              <% if value == 'same' %>
              <td style='color:green'><%= value %></td>
              <% else %>
                <td style='color:red'><%= value %></td>
              <% end %>
            </tr>
          <% end %>
			</table>
			<a href='file:///\\192.168.0.21\\AutoThc'>click here to view report</a>
		</body>
	</html>
html_end

  erb = ERB.new(html)
  send_email('qa@thc.net.cn', 'only for test', erb.result(binding))
end
