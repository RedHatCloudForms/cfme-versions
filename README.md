`CFME::Versions`
================

Command line utility and library for viewing versions across CloudForms (CF),
CloudForms Management Engine (CFME), and ManageIQ (MIQ).


Requirements
------------

- A `ruby` runtime


Installation
------------

### via `bundler`

Add the following to your `Gemfile`:

```ruby
gem 'cfme-versions'
```


### via `rubygems`

```console
$ gem install cfme-versions
```


Usage
-----

### CLI

```console
$ cfme-versions
```

There is a `--help` flag available for a few (minor) options.


### As a library

The `CFME::Versions` gem is also available as a `Enumerable` lib, so you can do
things like the following:

```ruby
require 'cfme-versions'

CFME::Versions.first.cfme_release
#=> "5.1.z"
CFME::Versions.first.cloud_forms_release
#=> "2.0"
CFME::Versions.last.miq_release
#=> "Jansa"
CFME::Versions.last.ruby
#=> "2.5.z"
CFME::Versions.last
#=> #<struct CFME::Version
#       miq_release="Jansa",
#       cfme_release="5.12.z",
#       cloud_forms_release="5.1",
#       ruby="2.5.z",
#       rails="5.2.z",
#       postgresql="10.y">
```


Contributing
------------

Bug reports and pull requests are welcome on [GitHub][].

If you wish to add a version to the list, make sure to run the tests and fix
any errors as a result (designed to fail when things change).

You can use `rake` to run the specs as you would expect.


License
-------

This project is available as open source under the [Apache License 2.0][].


[GitHub]:              https://github.com/RedHatCloudForms/cfme-versions
[Apache License 2.0]:  http://www.apache.org/licenses/LICENSE-2.0
