=begin
**************************************************************************************
	DefName: browse_data_file
	Description: browse data file
	ParameterList: file_path
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def browse_data_file(file_path)
	@browser.frame(:name, "content").frame(:name, "frame_uploadportfolio").file_field(:name, "exlFile").set file_path
end
=begin
**************************************************************************************
	DefName: select_portfolio_file_format
	Description: select portfolio data file format to upload
	ParameterList: radio_id
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def select_portfolio_file_format(radio_id)
  flag = false
  num = 0
  until flag
    num += 1
    begin
      @browser.frame(:name, "content").frame(:name, "frame_uploadportfolio").radio(:id, radio_id).set
      flag = true
    rescue => e
      puts e.message
      flag = false
    ensure
      flag = true if num > 30
    end
  end
end
=begin
**************************************************************************************
	DefName: click_upload_portfolio_button
	Description: click upload portfolio button
	ParameterList: 
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def click_upload_portfolio_button
	#@browser.frame(:name, "content").frame(:name, "frame_uploadportfolio").button(:id, "submit1").left_click
	@browser.frame(:name, "content").frame(:name, "frame_uploadportfolio").button(:id, "submit1").click
end
=begin
**************************************************************************************
	DefName: set_portfolio_name
	Description: set portfolio name
	ParameterList: portfolio_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def set_portfolio_name(portfolio_name)
	@browser.frame(:name, "content").frame(:name, "frame_uploadportfolio").text_field(:id, 'taskname_text').set portfolio_name
end
