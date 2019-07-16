require 'test_helper'

class IndiceTest < Minitest::Test
  include IndiceHelper

  def setup
    # Initialise JSON Parser
    json_parser = JsonParser.new
    # Setup user sample data
    @users_data = json_parser.call(file_path: 'bin/users.json')
    # Initialise indice for users
    @users_indice = Indice.new(data: @users_data)
  end

  def test_indice_gets_searchable_fields_correctly
    expected = get_user_searchable_fields()
    result = @users_indice.searchable_fields()
    assert_equal(expected, result)
  end

  def test_indice_performs_search_correctly
    expected = [{
      "_id"=>2,
      "url"=>"http://initech.zendesk.com/api/v2/users/2.json",
      "external_id"=>"c9995ea4-ff72-46e0-ab77-dfe0ae1ef6c2",
      "name"=>"Cross Barlow",
      "alias"=>"Miss Joni",
      "created_at"=>"2016-06-23T10:31:39 -10:00",
      "active"=>true,
      "verified"=>true,
      "shared"=>false,
      "locale"=>"zh-CN",
      "timezone"=>"Armenia",
      "last_login_at"=>"2012-04-12T04:03:28 -10:00",
      "email"=>"jonibarlow@flotonic.com",
      "phone"=>"9575-552-585",
      "signature"=>"Don't Worry Be Happy!",
      "organization_id"=>106,
      "tags"=>["Foxworth", "Woodlands", "Herlong", "Henrietta"],
      "suspended"=>false,
      "role"=>"admin"
    }]
    result = @users_indice.search(term: '_id', value: 2)
    assert_equal(expected, result)
  end
end
