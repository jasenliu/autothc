def init_folder(root_folder)
  date = Time.now.strftime('%Y%m%d')
  if !File.exist?("#{root_folder}/lib/report/generate_report/#{date}")
    Dir.mkdir("#{root_folder}/lib/report/generate_report/#{date}")
  end

  if !File.exist?("#{root_folder}/lib/report/generate_report/#{date}/Web13")
    Dir.mkdir("#{root_folder}/lib/report/generate_report/#{date}/Web13")
    Dir.mkdir("#{root_folder}/lib/report/generate_report/#{date}/Web173")
    Dir.mkdir("#{root_folder}/lib/report/generate_report/#{date}/WebThc")
  end

  if !File.exist?("#{root_folder}/lib/test result/#{date}")
    Dir.mkdir("#{root_folder}/lib/test result/#{date}")
		FileUtils.cp("#{root_folder}/lib/test result/TestResult.xls", "#{root_folder}/lib/test result/#{date}/TestResult.xls")
  end
end

