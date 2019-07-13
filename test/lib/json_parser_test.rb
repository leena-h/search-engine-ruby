require 'test_helper'

class JsonParserTest < Minitest::Test
  def setup
    @user_json_file_path = 'bin/users.json'
    @instance = JsonParser.new
  end

  def test_raises_error_if_file_path_non_existent
    # Error on non existent file path
    non_existent_file_path = 'bin/test.json'
    expected = "File path does not exist: #{non_existent_file_path}"
    exception = assert_raises ArgumentError do
      @instance.call(file_path: non_existent_file_path)
    end
    assert_equal(expected, exception.message)

    # Success on existent file path
    existent_file_path = @user_json_file_path
    result = @instance.call(file_path: existent_file_path)
    assert result.class == Array
  end

  def test_json_file_converts_to_hash
    expected = {
      "_id" => 1,
      "url" => "http://initech.zendesk.com/api/v2/users/1.json",
      "external_id" => "74341f74-9c79-49d5-9611-87ef9b6eb75f",
      "name" => "Francisca Rasmussen",
      "alias" => "Miss Coffey",
      "created_at" => "2016-04-15T05:19:46 -10:00",
      "active" => true,
      "verified" => true,
      "shared" => false,
      "locale" => "en-AU",
      "timezone" => "Sri Lanka",
      "last_login_at" => "2013-08-04T01:03:27 -10:00",
      "email"=>"coffeyrasmussen@flotonic.com",
      "phone"=>"8335-422-718",
      "signature" => "Don't Worry Be Happy!",
      "organization_id" => 119,
      "tags" => ["Springville", "Sutton", "Hartsville/Hartley", "Diaperville"],
      "suspended" => true,
      "role"=> "admin"
    }
    # Ensure records converted to hash properly - We check the first record only here.
    result = @instance.call(file_path: @user_json_file_path)
    assert_equal(expected, result[0])

    # Ensure all records are there
    expected_records_length = 75
    result_records_length = result.count
    assert_equal(expected_records_length, result_records_length)
  end
end
