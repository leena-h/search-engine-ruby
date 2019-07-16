class JsonParser
  def call(file_path:, map_key: '_id')
    # Throw error unless file path not found
    unless File.file?(file_path)
      raise ArgumentError.new("File path does not exist: #{file_path}")
    end
    # Read file path
    file = File.read(file_path)
    # Parse file in JSON format
    file_json = JSON.parse(file)
    # Map JSON by _id
    result = {}
    file_json.each do |j|
      id = j[map_key]
      result[id] = j
    end
    result
  rescue JSON::ParserError
    # Throw error if unable to parse JSON
    raise "Unable to parse JSON: #{file_path}"
  end
end
