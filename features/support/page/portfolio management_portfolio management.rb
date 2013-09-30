=begin
**************************************************************************************
	DefName: show_portfolio
	Description: verify uploaded fortfolio file exist or not
	ParameterList: portfolio_name
	Return:
	Author: LiuJingsen
	CreatedDate: 2011-12-16
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-16          LiuJingsen          create 
					2012-01-06          LiuJingsen          add time control
					2012-02-15          LiuJingSen          add build portfolio happened error judge
**************************************************************************************
=end
def show_portfolio(portfolio_name)
	begin_time = Time.now.to_i
=begin
  num = 0
  flag = false
  until flag
    num += 1
    begin
      sleep 1 until !@browser.frame(:name, "content").frame(:name, "frame_uploadportfolio").div(:id, 'popupMask-BODY-').exists?
      table = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_portlist')
      second_tr = table.[](1)  #get the second row
      if(second_tr.class_name == '')
        second_tr.attribute_value('pf_name').should == portfolio_name
        return 0
      elsif(second_tr.class_name == 'pf-error')
        puts "build portfolio failed"
        return 1
      end
      flag = true
    rescue => e
      puts e.message
      puts "get error::::"
      flag = false
    ensure
      flag = true if num > 50
    end
  end
=end
  

	sleep 1 until !@browser.frame(:name, "content").frame(:name, "frame_uploadportfolio").div(:id, 'popupMask-BODY-').exists?
	while(1 == 1)
		table = @browser.frame(:name, "content").frame(:name, "frame_reportsummary").table(:id, 'tbl_portlist')
		second_tr = table.[](1)  #get the second row
		if(second_tr.class_name == '')
			second_tr.attribute_value('pf_name').should == portfolio_name
			return 0
			break
		elsif(second_tr.class_name == 'pf-error')
			puts "build portfolio failed"
			return 1
			break
		end
		
		if(Time.now.to_i - begin_time > 120)
			puts "generate portfolio time is out"
			return 1
			break
		end
	end
end