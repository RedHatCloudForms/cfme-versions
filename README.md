`CFME::Versions`
================

Command line utility and library for viewing versions across CloudForms (CF),
CloudForms Management Engine (CFME), and ManageIQ (MIQ).

```console
$ cfme-versions
+----------------+------------------------------+------------+-------+-------+------------+
| MANAGEIQ       | CLOUDFORMS MANAGEMENT ENGINE | CLOUDFORMS | RUBY  | RAILS | POSTGRESQL |
+----------------+------------------------------+------------+-------+-------+------------+
|                | 5.1.z                        | 2.0        |       |       |            |
|                | 5.2.z                        | 3.0        |       |       |            |
| Anand          | 5.3.z                        | 3.1        |       |       |            |
| Botvinnik      | 5.4.z                        | 3.2        |       |       |            |
| Capablanca     | 5.5.z                        | 4.0        | 2.2.z | 4.2.z | 9.4.z      |
| Darga          | 5.6.z                        | 4.1        | 2.2.z | 5.0.z | 9.4.z      |
| Euwe           | 5.7.z                        | 4.2        | 2.3.z | 5.0.z | 9.5.z      |
| Fine           | 5.8.z                        | 4.5        | 2.3.z | 5.0.z | 9.5.z      |
| Gaprindashvili | 5.9.z                        | 4.6        | 2.3.z | 5.0.z | 9.5.z      |
| Hammer         | 5.10.z                       | 4.7        | 2.4.z | 5.0.z | 9.5.z      |
| Ivanchuk       | 5.11.z                       | 5.0        | 2.5.z | 5.1.z | 10.y       |
| Jansa          | 5.12.z                       | 5.1        | 2.5.z | 5.2.z | 10.y       |
+----------------+------------------------------+------------+-------+-------+------------+
```

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


Versioning
----------

Ideally we will keep the version of this gem in-sync with the version of the
most recent `y-stream` (minor) version release of CFME.  However, in the case
of bug fixes, patch versions might be included.

In the cases where this is need, just add to the `CFME::Versions.version`
method a `+ ".1"` to the end of the method to bump the version, and update
tests as needed.


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
