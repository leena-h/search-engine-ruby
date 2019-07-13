require 'json'

class Indice
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  def searchable_fields
    @data.map { |d| d.keys }.flatten.uniq.sort
  end

  def search(term:, value:)
    formatted_value = term == '_id' ? value.to_i : value
    @data.select { |d| d[term] == formatted_value } || []
  end
end
