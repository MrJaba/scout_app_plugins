# Ensures that a file exists
require 'scout'

class CheckFileExists < Scout::Plugin

  OPTIONS=<<-EOS
    path:
      name: path
      notes: path to the file which should exist
      default: /fully/qualified/path/to/your/file
  EOS

  def build_report
    begin
      path = option(:path)
      exists  = File.exists?(path)
      output = "Path: #{path}, exists?: #{exists}"
      report(:exists => exists, :path => path)
      if exists == false
        alert(:subject => "File #{path} did not exist")
      end
      return exists
    rescue Exception => e
      error(:subject => 'Error running Check Timestamp plugin', :body => e)
      return -1
    end
  end
end

