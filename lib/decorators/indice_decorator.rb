class IndiceDecorator
  def initialize(obj)
    @obj = obj
  end

  def to_pretty_string()
    return "No results found." if @obj.empty?

    result = ""
    @obj.each do |hash|
      result += formatted_values(hash)
    end
    result
  end

  def formatted_values(hash)
    result = []
    hash.each do |k, v|
      if related_record_keys.include?(k)
        result << "\nRELATED #{k.upcase.sub('_', ' ')}\n"
        result << v.map { |nested_obj| formatted_nested_record(nested_obj) }.join("\n")
        result << "\n"
      else
        result << "#{k}: #{v}\n"
      end
    end
    result.join('').chomp
  end

  private

  def related_record_keys
    ['submitted_tickets', 'assigned_tickets', 'organizations']
  end

  def formatted_nested_record(obj)
    obj.map { |key, value| "#{key}: #{value}\n" }.join('')
  end
end
