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
	while(1 == 1)
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
	report_name += '-1'
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
	close_ie_process
end
	