=begin
**************************************************************************************
	DefName: click_tab_by_name
	Description: switch to different module by their tab name
	ParameterList: tab_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def click_tab_by_name(tab_name)
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'tabArea').link(:text, tab_name).click
end
=begin
**************************************************************************************
	DefName: select_portfolio_type
	Description: choose portfolio type by radio ID
	ParameterList: radio_id
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def select_portfolio_type(radio_id)
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').radio(:id, radio_id).set
end
=begin
**************************************************************************************
	DefName: select_portfolio_by_name
	Description: choose portfolio from portfolio list
	ParameterList: portfolio_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-16
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-16         LiuJingsen          create 
**************************************************************************************
=end
def select_portfolio_by_name(portfolio_name)
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'combo_portfolio').click
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'port_list').link(:text, portfolio_name).click
end
=begin
**************************************************************************************
	DefName: select_report
	Description: choose report type 
	ParameterList: checkbox_value
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-16
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-16         LiuJingsen          create 
**************************************************************************************
=end
def select_report(checkbox_value)
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'div_ReportContainer').checkbox(:value, checkbox_value).set
end
=begin
**************************************************************************************
	DefName: set_report_name
	Description: set report name
	ParameterList: report_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-16
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-16         LiuJingsen          create 
**************************************************************************************
=end
def set_report_name(report_name)
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').text_field(:name, 'txtName').set report_name
end
=begin
**************************************************************************************
	DefName: click_generate_button
	Description: click generate button
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-16
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-16         LiuJingsen          create 
**************************************************************************************
=end
def click_generate_button
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'div_batchReportList').button(:id, 'btn_generate').click
end
=begin
**************************************************************************************
	DefName: set_report_format
	Description: set report format
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-19
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-19         LiuJingsen          create 
					2011-12-29         LiuJingsen          delete the parameter
**************************************************************************************
=end
def set_report_format
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').checkbox(:id, 'pdfFormat').clear
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').checkbox(:id, 'excelFormat').set
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').checkbox(:id, 'wordFormat').clear
end
=begin
**************************************************************************************
	DefName: calculation_setting
	Description: calculation setting
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-29
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-29         LiuJingsen          create 
**************************************************************************************
=end
def calculation_setting
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').select_list(:id, 'selCalSet').set('1-1')
end
=begin
**************************************************************************************
	DefName: set_priority
	Description: set priority
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-29
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-29         LiuJingsen          create 
**************************************************************************************
=end
def set_priority
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').radio(:id, 'priority1').set
end
=begin
**************************************************************************************
	DefName: select_cycle
	Description: select cycle value
	ParameterList: cycle_value
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-29
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-29         LiuJingsen          create 
**************************************************************************************
=end
def select_cycle(cycle_value)
	@browser.frame(:name, "content").frame(:name, "frame_reportsummary").div(:id, 'generateFrame').select_list(:name, 'portcycle').set(cycle_value)
end
