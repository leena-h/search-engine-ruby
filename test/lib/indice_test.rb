require 'test_helper'

class IndiceTest < Minitest::Test
  def setup
    @file_path = 'bin/users.json'
    @instance = Indice.new(file_path: @file_path)
  end

  def test_raises_error_if_file_path_non_existent
    # Error on non existent file path
    non_existent_file_path = 'bin/test.json'
    expected = "File path does not exist: #{non_existent_file_path}"
    exception = assert_raises ArgumentError do
      Indice.new(file_path: non_existent_file_path)
    end
    assert_equal(expected, exception.message)

    # Success on existent file path
    existent_file_path = 'bin/users.json'
    result = Indice.new(file_path: existent_file_path)
    result_file_path = result.file_path
    assert_equal(existent_file_path, result_file_path)
  end
end
