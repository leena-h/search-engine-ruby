require 'json'

class Indice
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  # Retrieve all searchable fields
  def searchable_fields
    @data.map { |d| d.keys }.flatten.uniq.sort
  end

  # Performs search on given term and value
  def search(term:, value:)
    @data.select { |d| d[term] == value } || []
  end
end
