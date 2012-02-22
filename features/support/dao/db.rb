=begin
**************************************************************************************
	DefName: clear_report_list
	Description: clear the report list
	ParameterList: host
								 username
								 password
	Return:

	Author: LiuJingsen
	CreatedDate: 2011-12-30
**************************************************************************************
	History: Date                Changer      			Reason
          2011-12-30          LiuJingsen          create 
**************************************************************************************
=end
def clear_report_list(host, username, password)
	db = SqlServer.new(host, username, password)
	db.open('C0702')
	sql = "delete from reportinfo where creatorid = 310"
	db.execute(sql)
	db.close
end
=begin
**************************************************************************************
	DefName: get_max_loan_file_id
	Description: get max loan file id
	ParameterList: host
								 username
								 password
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-11
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-11          LiuJingsen          create 
**************************************************************************************
=end
def get_max_loan_file_id(host, username, password)
	db = SqlServer.new(host, username, password)
	db.open('C0702')
	sql = "select max(pkid) from loanfile where userid = 310"
	db.query(sql)
	loan_file_id = db.data[0].to_s
	db.close
	return loan_file_id
end
=begin
**************************************************************************************
	DefName: get_repot_ids
	Description: get three generated report id
	ParameterList: host
								 username
								 password
	Return:

	Author: LiuJingsen
	CreatedDate: 2012-01-11
**************************************************************************************
	History: Date                Changer      			Reason
          2012-01-11          LiuJingsen          create 
**************************************************************************************
=end
def get_repot_ids(host, username, password)
	db = SqlServer.new(host, username, password)
	db.open('C0702')
	sql = "select max(StrategyPortfolioId) from loanfile where userid = 310"
	db.query(sql)
	portfolio_id = db.data[0].to_s.to_i
	sql1 = "select id from reportinfo where pfids = ',#{portfolio_id},'"
	db.query(sql1)
	ids = db.data
	db.close
	return ids
end
