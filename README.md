#email_regex

Author: [Doug Wiegley](mailto:doug@parksidesoftware.com)

##Description

Provides a valid email regex that conforms to most valid RFC edges cases (disallows backticks), and allows for a few illegal patterns that are in common use.

##Installation

###For a rails application

Add the gem to your gemfile.
```ruby
gem 'email_regex'
```

Then bundle install.
```bash
$ bundle install
```

###Install the gem on its own

```bash
$ gem install email_regex
```

##Usage

The regex is then accessible with the following:

```ruby
EmailRegex::EMAIL_ADDRESS_REGEX
```

An example:
```ruby
%w(invalid_email valid_email@example.com).select { |e| e if e =~ EmailRegex::EMAIL_ADDRESS_REGEX }
=> [valid_email@example.com]
```

###With ActiveRecord

This can be used with an ActiveRecord validation in two ways:

####With `validates_format_of`

```ruby
class User < ActiveRecord::Base
  attr_accessible :email
  validates_format_of :email, with: EmailRegex::EMAIL_ADDRESS_REGEX
end
```

####With a custom validator

```ruby
class User < ActiveRecord::Base
  attr_accessible :email
  validates :email, presence: true, email_format: true
end
```

Then, in lib/validators/email_format_validator.rb:
```ruby
class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ EmailRegex::EMAIL_ADDRESS_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end
end
```

##Copyright

See LICENSE.txt for more details

