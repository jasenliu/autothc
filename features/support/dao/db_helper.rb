class SqlServer
  # This class manages database connection and queries
  attr_accessor :connection, :data, :fields
	attr_writer :username, :password

  def initialize(host, username = 'sa', password='thcdm021*')
    @connection = nil
    @data = nil
	  @host = host
		@username = username
		@password = password
  end

  def open(database)
    # Open ADO connection to the SQL Server database
    connection_string =  "Provider=SQLOLEDB.1;"
    connection_string << "Persist Security Info=False;"
    connection_string << "User ID=#{@username};"
    connection_string << "password=#{@password};"
    connection_string << "Initial Catalog=#{database};"
    connection_string << "Data Source=#{@host};"
    connection_string << "Network Library=dbmssocn"
    @connection = WIN32OLE.new('ADODB.Connection')
    @connection.Open(connection_string)
  end

  def query(sql)
    # Create an instance of an ADO Recordset
    recordset = WIN32OLE.new('ADODB.Recordset')
    # Open the recordset, using an SQL statement and the
    # existing ADO connection
    recordset.Open(sql, @connection)
    # Create and populate an array of field names
    @fields = []
    recordset.Fields.each do |field|
      @fields << field.Name
    end
    begin
      # Move to the first record/row, if any exist
      recordset.MoveFirst
      # Grab all records
      @data = recordset.GetRows
    rescue
      @data = []
    end
    recordset.Close
    # An ADO Recordset's GetRows method returns an array 
    # of columns, so we'll use the transpose method to 
    # convert it to an array of rows
    @data = @data.transpose
  end
	
	def execute(sql)        
		@connection.Execute(sql)    
	end

  def close
    @connection.Close
  end
end