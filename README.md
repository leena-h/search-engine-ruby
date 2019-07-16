# Zendesk Coding Challenge

## OVERVIEW

Using the provided data (tickets.json and users.json and organization.json) write a simple
command line application to search the data and return the results in a human readable format.

* Feel free to use libraries or roll your own code as you see fit.
* Where the data exists, values from any related entities should be included in the results, i.e. searching organization by id should return its tickets and users.
* The user should be able to search on any field, full value matching is fine (e.g. "mar" won't return "mary").
* The user should also be able to search for empty values, e.g. where description is empty.

Search can get pretty complicated pretty easily, we just want to see that you can code a basic but efficient search application. Ideally, search response times should not increase linearly as the number of documents grows. You can assume all data can fit into memory on a single
machine.

## EVALUATION CRITERIA

We will look at your project and assess it for:
1. Extensibility - separation of concerns.
2. Simplicity - aim for the simplest solution that gets the job done whilst remaining readable, extensible and testable.
3. Test Coverage - breaking changes should break your tests.
4. Performance - should gracefully handle a significant increase in amount of data provided (e.g 10000+ users).
5. Robustness - should handle and report errors.If you have any questions about this criteria please ask.

### SPECIFICATIONS

- Use the language in which you are strongest.
- Include a README with (accurate) usage instructions.
- Document the assumptions and tradeoffs you’ve made.

## Thoughts / Design Process
As this is production code, I've written TDD tests prior to implementation.

Service design pattern is utilised to seperate each section of business logic into different classes.
The benefit of doing so allows us to test each layer effectively.

### Search Engine
This class is used to determine which indice to query for records or view searchable fields.
It will contain access to 3 datasets or indices:
- Organizations (Read from JSON using JsonParser class)
- Tickets (Read from JSON using JsonParser class)
- Users (Read from JSON using JsonParser class)

### Indice
This class is a dataset representation for Organizations/Tickets/Users.
It contains functions to do the following:
- View searchable fields
- Search by term and value (Iterates through each record to find a match)
- Search by primary key (Get record from mapping by id) - O(1) Algorithm

### Indice Decorator
This class is used to make the results from Search Engine human readable.

### CLI
This class is used for user input and interactions.

## How to start
Ruby version required: `2.6.0`

Install gems
I've only included Gems for MiniTest and pry for debugging purposes.
`bundle install`

To run the CLI, run the following command in the terminal:
`ruby cli.rb`
