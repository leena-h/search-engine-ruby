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
    @data.select { |d| d[term] == value } || []
  end
end
