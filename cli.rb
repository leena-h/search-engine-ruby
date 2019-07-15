require 'pry'
require_relative './lib/search_engine'
require_relative './lib/decorators/indice_decorator'

class Cli
  def initialize
    @search_engine = SearchEngine.new
  end

  def run
    option = 0
    while option != 3
      welcome_prompt
      prompt
      option = gets.chomp.to_i
      breakline

      case option
      when 1
        puts "Select 1) Users or 2) Tickets or 3) Organizations"
        indice_number = gets.chomp
        indice_type = indice_number_mapping(indice_number)
        puts "Enter search term"
        term = gets.chomp
        puts "Enter search value"
        value = gets.chomp
        formatted_value = convert_id_to_integer_unless_for_tickets(term, indice_type, value)
        result = @search_engine.perform_search(
          indice_type: indice_type,
          term: term,
          value: formatted_value
        )
        puts IndiceDecorator.new(result).to_pretty_string()
        breakline
      when 2
        searchable_fields_prompt
      when 3
      else
        puts 'Invalid option. Try again.'
        breakline
        prompt
      end
    end
  end

  private

  def prompt
    print '> '
  end

  def breakline
    puts "\n"
  end

  def welcome_prompt
    puts """
      Welcome to Zendesk Search
      Type 'quit' to exit at any time, Press 'Enter' to continue

        Select search options:
        * Press 1 to search Zendesk
        * Press 2 to view a list of searchable fields
        * Press 3 to exit
    """
  end

  def searchable_fields_prompt
    puts "--------------------------------------------------"
    puts "Search Users with"
    puts @search_engine.view_searchable_fields(:users)
    breakline
    puts "--------------------------------------------------"
    puts "Search Tickets with"
    puts @search_engine.view_searchable_fields(:tickets)
    breakline
    puts "--------------------------------------------------"
    puts "Search Organizations with"
    puts @search_engine.view_searchable_fields(:organizations)
    breakline
  end

  def indice_number_mapping(number = 0)
    case number.to_i
    when 1
      :users
    when 2
      :tickets
    when 3
      :organizations
    end
  end

  def convert_id_to_integer_unless_for_tickets(term, indice_type, value)
    if term == '_id' && indice_type != :tickets
      value.to_i
    else
      value
    end
  end
end

Cli.new.run()
