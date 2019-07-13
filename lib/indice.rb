require 'json'

class Indice
  attr_reader :data

  def initialize(data:)
   @data = data
  end

  def query
  end

  def searchable_fields
  end
end
