=begin
**************************************************************************************
	DefName: navigate_to_page
	Description: navigate to specified page
	ParameterList: page_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def navigate_to_page(page_name)
	@browser.frame(:name, "nav").link(:text, page_name).click
end
=begin
**************************************************************************************
	DefName: run_js
	Description: run javascript statement
	ParameterList: js_string
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-19
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-19          LiuJingsen          create 
**************************************************************************************
=end
def run_js(js_string)
	@browser.execute_script(js_string) 
end
=begin
**************************************************************************************
	DefName: close_ie_process
	Description: close all ie process
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-26
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-26         LiuJingsen          create 
**************************************************************************************
=end
def close_ie_process
  mgmt = WIN32OLE.connect('winmgmts:\\\\.')
  processes=mgmt.instancesof("win32_process")
  processes.each do |process|
    #puts process
    if process.name =="iexplore.exe" then       
       process.terminate
    end
		if process.name =="IEXPLORE.EXE" then       
       process.terminate
    end
  end
end
=begin
**************************************************************************************
	DefName: clear_cookie
	Description: clear IE cookie
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-28
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-28         LiuJingsen          create 
**************************************************************************************
=end
def clear_cookie
	dir= "C:\\Documents and Settings\\"+ENV['USERNAME']+"\\Local Settings\\Temporary Internet Files"
  FileUtils.rm_rf dir
end
=begin
**************************************************************************************
	DefName: get_dialog_text
	Description: get dialog text
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2012-2-14
**************************************************************************************
	History: Date                Changer      			Reason
          2012-2-14           LiuJingsen          create 
**************************************************************************************
=end
def get_dialog_text
	js = Watir::JavascriptDialog.new
	js.text()
end
=begin
**************************************************************************************
	DefName: click_dialog_ok_button
	Description: click ok button of javascript dialog
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2012-2-14
**************************************************************************************
	History: Date                Changer      			Reason
          2012-2-14           LiuJingsen          create 
**************************************************************************************
=end
def click_dialog_ok_button
	js = Watir::JavascriptDialog.new
	js.button("OK").click
end