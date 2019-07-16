require 'json'

class Indice
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  # Retrieve all searchable fields
  def searchable_fields
    @data.map { |id, v| v.keys }.flatten.uniq.sort
  end

  # Performs search on given term and value
  def search(term:, value:)
    @data.select { |k, v| v[term] == value }.values || []
  end

  def search_by_primary_key(value:)
    [@data[value]] || []
  end
end
