require 'test_helper'

class SearchEngineTest < Minitest::Test
  include IndiceHelper

  def setup
    @instance = SearchEngine.new
  end

  def test_returns_correct_specified_indice_searchable_fields
    # Ensure organizations indice and fields are returned if specified
    organization_fields = get_organization_searchable_fields()
    organization_fields_result = @instance.view_searchable_fields(:organizations)
    assert_equal(organization_fields, organization_fields_result)

    # Ensure users indice and fields are returned if specified
    users_fields = get_user_searchable_fields()
    users_fields_result = @instance.view_searchable_fields(:users)
    assert_equal(users_fields, users_fields_result)

    # Ensure tickets indice and fields are return if specified
    ticket_fields = get_ticket_searchable_fields()
    ticket_fields_result = @instance.view_searchable_fields(:tickets)
    assert_equal(ticket_fields, ticket_fields_result)
  end

  def test_searching_with_no_id_should_return_record_only
    # Searching for user by name of 'Francisca Rasmussen' and should only return the record only
    expected = user_without_related_records()
    result = @instance.perform_search(indice_type: 'users', term: 'name', value: 'Francisca Rasmussen')
    result_keys = result.map {|hit| hit.keys}.flatten.uniq

    user_result = result[0]
    assert result.length == 1 # There is only 1 record
    assert_equal(expected, user_result) # User record is there
    refute result_keys.include?('organizations') # Does not include organizations
    refute result_keys.include?('submitted_tickets') # Does not include submitted tickets
    refute result_keys.include?('assigned_tickets') # Does not include assigned tickets
  end

  def test_searching_with_id_should_return_record_and_related_records
    # Search by User ID should return related tickets and organization
    expected = user_with_related_records()
    result = @instance.perform_search(indice_type: 'users', term: '_id', value: 1)
    result_keys = result.map {|hit| hit.keys}.flatten.uniq

    # Format results to have array of ids to easily compare objects
    result.each do |user|
      user['assigned_ticket_ids'] = user['assigned_tickets'].map { |at| at['_id'] }
      user['submitted_ticket_ids'] = user['submitted_tickets'].map { |st| st['_id'] }
      user['organization_ids'] = user['organizations'].map { |st| st['_id'] }
    end

    user_result = result[0]
    assert result.length == 1 # There is only 1 record
    assert result_keys.include?('organizations') # Does include organizations
    assert result_keys.include?('submitted_tickets') # Does include submitted tickets
    assert result_keys.include?('assigned_tickets') # Does include assigned tickets
    assert_equal(expected['_id'], user_result['_id']) # User id is 1
    assert_equal(expected['assigned_ticket_ids'], user_result['assigned_ticket_ids'])
    assert_equal(expected['submitted_ticket_ids'], user_result['submitted_ticket_ids'])
    assert_equal(expected['organization_ids'], user_result['organization_ids'])
  end

  private

  def user_without_related_records
    {
      "_id"=> 1,
      "url" => "http://initech.zendesk.com/api/v2/users/1.json",
      "external_id" => "74341f74-9c79-49d5-9611-87ef9b6eb75f",
      "name" => "Francisca Rasmussen",
      "alias" => "Miss Coffey",
      "created_at" => "2016-04-15T05:19:46 -10:00",
      "active"=> true,
      "verified"=> true,
      "shared"=> false,
      "locale" => "en-AU",
      "timezone" => "Sri Lanka",
      "last_login_at" => "2013-08-04T01:03:27 -10:00",
      "email" => "coffeyrasmussen@flotonic.com",
      "phone" => "8335-422-718",
      "signature" => "Don't Worry Be Happy!",
      "organization_id"=> 119,
      "tags" => [
        "Springville",
        "Sutton",
        "Hartsville/Hartley",
        "Diaperville"
      ],
      "suspended"=> true,
      "role" => "admin"
    }
  end

  def user_with_related_records
    {
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
      "email" => "coffeyrasmussen@flotonic.com",
      "phone" => "8335-422-718",
      "signature" => "Don't Worry Be Happy!",
      "organization_id"=>119,
      "tags" => [
        "Springville",
        "Sutton",
        "Hartsville/Hartley",
        "Diaperville"
      ],
      "suspended" => true,
      "role" => "admin",
      "organization_ids"=> [119],
      "submitted_ticket_ids"=> [
        "fc5a8a70-3814-4b17-a6e9-583936fca909",
        "cb304286-7064-4509-813e-edc36d57623d",
      ],
      "assigned_ticket_ids"=> [
        "1fafaa2a-a1e9-4158-aeb4-f17e64615300",
        "13aafde0-81db-47fd-b1a2-94b0015803df"
      ]
    }
  end
end
