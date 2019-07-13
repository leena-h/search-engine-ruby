require 'json'

class Indice
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  def searchable_attributes
    @data.map { |d| d.keys }.flatten.uniq
  end

  def query
  end
end
