require 'test_helper'

class IndiceTest < Minitest::Test
  def setup
    # Initialise JSON Parser
    json_parser = JsonParser.new
    # Setup user sample data
    @users_data = json_parser.call(file_path: 'bin/users.json')
    # Setup ticket sample data
    @tickets_data = json_parser.call(file_path: 'bin/tickets.json')
    # Initialise indice for users

  end

  def test_indice_gets_searchable_fields_correctly
    expected_user_searchable_fields = [
      "_id",
      "url",
      "external_id",
      "name",
      "alias",
      "created_at",
      "active",
      "verified",
      "shared",
      "locale",
      "timezone",
      "last_login_at",
      "email",
      "phone",
      "signature",
      "organization_id",
      "tags",
      "suspended",
      "role"
    ]
  end
end
