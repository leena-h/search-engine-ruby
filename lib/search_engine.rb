require_relative 'indice'
require_relative 'json_parser'

class SearchEngine
  def initialize(parser: JsonParser.new)
    @organizations_indice =
      Indice.new(data: parser.call(file_path: 'bin/organizations.json'))
    @tickets_indice =
      Indice.new(data: parser.call(file_path: 'bin/tickets.json'))
    @users_indice =
      Indice.new(data: parser.call(file_path: 'bin/users.json'))
  end

  def perform_search(indice_type:, term:, value: '')
    case indice_type.to_sym
    when :organizations
      search_organizations(term, value)
    when :tickets
      search_tickets(term, value)
    when :users
      search_users(term, value)
    else
      []
    end
  end

  # TODO: Show related fields
  def view_searchable_fields(indice_type)
    case indice_type.to_sym
    when :organizations
      @organizations_indice.searchable_fields
    when :tickets
      @tickets_indice.searchable_fields
    when :users
      @users_indice.searchable_fields
    else
      []
    end
  end

  private

  def perform_search_by_id?(term)
    term == '_id'
  end

  # Returns organisations with related users and tickets
  def search_organizations(term, value)
    results = @organizations_indice.search(term: term, value: value)
    if perform_search_by_id?(term)
      results.each do |organization|
        # Get related tickets
        organization['tickets'] =
          @tickets_indice.search(term: 'organization_id', value: organization['_id'])

        # Get related users
        organization['users'] =
          @users_indice.search(term: 'organization_id', value: organization['_id'])
      end
    end
    results
  end

  # Return tickets with related users and organisations
  def search_tickets(term, value)
    results = @tickets_indice.search(term: term, value: value)
    if perform_search_by_id?(term)
      results.each do |ticket|
        # Get related organizations
        ticket['organizations'] =
          @organizations_indice.search_by_primary_key(value: ticket['organization_id'])

        # Get related users who are submitters
        ticket['submitters'] =
          @users_indice.search_by_primary_key(value: ticket['submitter_id'])

        # Get related users who are assignees
        ticket['assignees'] =
          @users_indice.search_by_primary_key(value: ticket['assignee_id'])
      end
    end
    results
  end

  # Return users with related tickets and organisations
  def search_users(term, value)
    results = @users_indice.search(term: term, value: value)
    if perform_search_by_id?(term)
      results.each do |user|
        # Get related organizations
        user['organizations'] =
          @organizations_indice.search_by_primary_key(value: user['organization_id'])

        # Get submitted tickets related to user
        user['submitted_tickets'] =
          @tickets_indice.search(term: 'submitter_id', value: user['_id'])

        # Get assigned tickets related to user
        user['assigned_tickets'] =
          @tickets_indice.search(term: 'assignee_id', value: user['_id'])
      end
    end
    results
  end
end
