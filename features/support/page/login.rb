=begin
**************************************************************************************
	DefName: login
	Description: login the thc system
	ParameterList: username
								 password
								 url
	Return:

	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
					2011-12-30          LiuJingsen          add parameter url
**************************************************************************************
=end
def login(username, password, url)
	@browser.goto url
	
	@browser.text_field(:id, "lgnName").set username
	@browser.text_field(:name, "lgnPass").set password

	click_login_button
end
=begin
**************************************************************************************
	DefName: login_without_username_password
	Description: login without username and password
	ParameterList: 
	Return:

	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def login_without_username_password
	click_login_button
end
=begin
**************************************************************************************
	DefName: click_login_button
	Description: click login button
	ParameterList: 
	Return:

	Author: LiuJingsen
	CreatedDate: 2011-12-14
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-14          LiuJingsen          create 
**************************************************************************************
=end
def click_login_button
	@browser.button(:name, "submit1").click
end

