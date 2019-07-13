class JsonParser
  def call(file_path:)
    # Throw error unless file path not found
    unless File.file?(file_path)
      raise ArgumentError.new("File path does not exist: #{file_path}")
    end
    # Read file path
    file = File.read(file_path)
    # Return parse file in JSON format
    JSON.parse(file)
  rescue JSON::ParserError
    # Throw error if unable to parse JSON
    raise "Unable to parse JSON: #{file_path}"
  end
end
