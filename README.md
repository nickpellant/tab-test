# TAB Ruby Technical Test

[![Build Status](https://travis-ci.org/nickpellant/tab-test.svg?branch=master)](https://travis-ci.org/nickpellant/tab-test)

This project is a technical demonstration provided for [The App Business](http://theappbusiness.com).

## Improvements and Refactors
* Given additional time I would choose to refactor out the body encryption and the password authentication from the note model into seperate service objects to cleanup the controller.

## Testing

This project uses [RSpec](https://relishapp.com/rspec) as its testing framework.

## Security

Although I am aware of `has_secure_password` as documented [here](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password) I decided to implement the password through BCrypt by hand to demo my understanding of it.

## Database

### Caveats & Comments

* This application uses [SQLite](http://sqlite.org) so as to speed up the database configuration for this example. In a real world use case for a growing application I would instead opt for [PostgreSQL](http://postgresql.org).
* In a production environment I tend to favour when using [PostgreSQL UUID's](http://www.postgresql.org/docs/9.1/static/datatype-uuid.html) for identifiers. In this case for the `Note` model I've used default integer identifiers to speed things up.
