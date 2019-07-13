class Indice
  attr_reader :file_path

  def initialize(file_path:)
    unless File.file?(file_path)
      raise ArgumentError.new("File path does not exist: #{file_path}")
    end

    @file_path = file_path
  end

  def query
  end

  def searchable_fields
  end

  private

  def parse_json
  end
end
