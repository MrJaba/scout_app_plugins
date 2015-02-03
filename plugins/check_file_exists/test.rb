require "minitest/autorun"

require_relative "./check_file_exists"

class TestCheckFileExists < Minitest::Test

  def test_file_exists
    with_existing_file do |file_path| 
      plugin = CheckFileExists.new(nil, memory = {},options = {path: file_path})
      result = plugin.run
      assert result[:reports].first[:exists] == true
    end
  end

  def test_file_does_not_exist
    plugin = CheckFileExists.new(nil, memory = {},options = {path: "empty"})
    result = plugin.run
    assert result[:reports].first[:exists] == false
  end

  def with_existing_file
    file_path = File.dirname(__FILE__)+"/test_file"
    File.open(file_path, "w") do |f|     
      f.write("test")
    end
    
    yield file_path

    File.delete(file_path)
    
  end

end
