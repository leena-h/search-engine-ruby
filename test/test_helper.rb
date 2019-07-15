require 'minitest/reporters'
require 'minitest/autorun'
require 'pry'

Dir[Dir.pwd + "/lib/*.rb"].each {|file| require file }
require_relative '../lib/decorators/indice_decorator'

Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)

class Minitest::Unit::TestCase
end

module IndiceHelper
  def get_organization_searchable_fields
    [
      "_id",
      "url",
      "external_id",
      "name",
      "domain_names",
      "created_at",
      "details",
      "shared_tickets",
      "tags"
    ].sort
  end

  def get_user_searchable_fields
    [
      "_id",
      "active",
      "alias",
      "created_at",
      "email",
      "external_id",
      "last_login_at",
      "locale",
      "name",
      "organization_id",
      "phone",
      "role",
      "shared",
      "signature",
      "suspended",
      "tags",
      "timezone",
      "url",
      "verified"
    ].sort
  end

  def get_ticket_searchable_fields
    [
      "_id",
      "assignee_id",
      "created_at",
      "description",
      "due_at",
      "external_id",
      "has_incidents",
      "organization_id",
      "priority",
      "status",
      "subject",
      "submitter_id",
      "tags",
      "type",
      "url",
      "via"
    ].sort
  end
end
