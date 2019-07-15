require_relative 'indice'
require_relative 'json_parser'

class SearchEngine
  # Initialise dataset - Organisations, tickets and users
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
        organization[:related_records] = {}
        organization[:related_records]['tickets'] =
          @tickets_indice.search(term: 'organization_id', value: value)
        organization[:related_records]['users'] =
          @users_indice.search(term: 'organization_id', value: value)
      end
    end
    results
  end

  # Return tickets with related users and organisations
  def search_tickets(term, value)
    results = @tickets_indice.search(term: term, value: value)
    if perform_search_by_id?(term)
      results.each do |ticket|
        # TODO: Remove it deeper into the record, incase it clashes
        # Refactor - Users indice has to go through loop twice
        ticket[:related_records] = {}
        ticket[:related_records]['organizations'] =
          @organizations_indice.search(term: '_id', value: ticket['organization_id'])
        ticket[:related_records]['submitters'] =
          @users_indice.search(term: '_id', value: ticket['submitter_id'])
        ticket[:related_records]['assignees'] =
          @users_indice.search(term: '_id', value: ticket['assignee_id'])
      end
    end
    results
  end

  # Return users with related tickets and organisations
  def search_users(term, value)
    results = @users_indice.search(term: term, value: value)
    if perform_search_by_id?(term)
      results.each do |user|
        user[:related_records] = {}
        # TODO: Remove it deeper into the record, incase it clashes
        user[:related_records]['organizations'] =
          @organizations_indice.search(term: '_id', value: user['organization_id'])
        # Refactor - Tickets indice has to go through loop twice
        user[:related_records]['submitted_tickets'] =
          @tickets_indice.search(term: 'submitter_id', value: value)
        user[:related_records]['assigned_tickets'] =
          @tickets_indice.search(term: 'assignee_id', value: value)
      end
    end
    results
  end
end
