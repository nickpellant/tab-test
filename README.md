# TAB Ruby Technical Test

This project is a technical demonstration provided for [The App Business](http://theappbusiness.com).

## Testing

This project uses [RSpec](https://relishapp.com/rspec) as its testing framework.

## Database

### Caveats & Comments

* This application uses [SQLite](http://sqlite.org) so as to speed up the database configuration for this example. In a real world use case for a growing application I would instead opt for [PostgreSQL](http://postgresql.org).
* In a production environment I tend to favour when using [PostgreSQL UUID's](http://www.postgresql.org/docs/9.1/static/datatype-uuid.html) for identifiers. In this case for the `Note` model I've used default integer identifiers to speed things up.
