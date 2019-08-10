# Search Engine

## OVERVIEW

Using the provided data (tickets.json and users.json and organization.json) write a simple
command line application to search the data and return the results in a human readable format.

* Feel free to use libraries or roll your own code as you see fit.
* Where the data exists, values from any related entities should be included in the results, i.e. searching organization by id should return its tickets and users.
* The user should be able to search on any field, full value matching is fine (e.g. "mar" won't return "mary").
* The user should also be able to search for empty values, e.g. where description is empty.

Search can get pretty complicated pretty easily, we just want to see that you can code a basic but efficient search application. Ideally, search response times should not increase linearly as the number of documents grows. You can assume all data can fit into memory on a single
machine.

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
