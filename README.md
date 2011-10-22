Nagios Parser
=============

[![Build Status](https://secure.travis-ci.org/bernd/nagios_parser.png)](http://travis-ci.org/bernd/nagios\_parser])

# Description

The `nagios_parser` gem provides a parser for the Nagios `status.dat`
files and a parser for the Nagios object definition files.

* NagiosParser::Status::Parser
* NagiosParser::Object::Parser
* NagiosParser::Config::Parser
* NagiosParser::Resource::Parser

Both parsers return plain hashes and arrays. There are no special
Nagios objects or something like that. That means you can create
your own wrapping objects or use the simple data structure
directly.

# Installation

    # gem install nagios_parser

# Usage

## Status Parser

    require 'nagios_parser/status/parser'
    require 'pp'

    status = <<-STATUS
      info {
              created=1291408262
              version=3.2.0
              last_update_check=1291201457
              update_available=1
              last_version=3.2.0
              new_version=3.2.3
              }
      hoststatus {
              host_name=server1
              modified_attributes=0
              check_command=check-ping
              check_period=24x7
              notification_period=24x7
              check_interval=5.000000
              retry_interval=1.000000
              event_handler=
              has_been_checked=1
              }
    STATUS

    data = NagiosParser::Status::Parser.parse(status)
    pp data

This will print a data structure that looks like this.

    {"info"=>
      [{"last_version"=>"3.2.0",
        "version"=>"3.2.0",
        "last_update_check"=>1291201457,
        "new_version"=>"3.2.3",
        "update_available"=>1,
        "created"=>1291408262}],
     "hoststatus"=>
      [{"check_command"=>"check-ping",
        "host_name"=>"server1",
        "notification_period"=>"24x7",
        "check_period"=>"24x7",
        "modified_attributes"=>0,
        "retry_interval"=>"1.000000",
        "has_been_checked"=>1,
        "event_handler"=>nil,
        "check_interval"=>"5.000000"}]}

## Object Parser

    require 'nagios_parser/object/parser'
    require 'pp'

    object = <<-OBJECT
      define command {
              command_name check-http
              command_line $USER1$/check_http -I $HOSTADDRESS$ -w 420 -c 840
      }
      define host {
        host_name server1
        alias     server1.example.com
        address   10.0.0.1
      }
    OBJECT

    data = NagiosParser::Object::Parser.parse(object)
    pp data

This will print a data structure that looks like this.

    {"command"=>
      [{"command_name"=>"check-http",
        "command_line"=>"$USER1$/check_http -I $HOSTADDRESS$ -w 420 -c 840"}],
     "host"=>
      [{"address"=>"10.0.0.1",
        "host_name"=>"server1",
        "alias"=>"server1.example.com"}]}

## Config Parser

    require 'nagios_parser/config/parser'
    require 'pp'

    config = <<-CONFIG
      log_file=/var/log/nagios3/nagios.log
      status_update_interval=10
    CONFIG

    data = NagiosParser::Config::Parser.parse(config)
    pp data

This will print a data structure that looks like this.

    {"log_file"=>"/var/log/nagios3/nagios.log",
     "status_update_interval"=>10}

## Resource macro parser

    require 'nagios_parser/resource/parser'
    require 'pp'

    resource = <<-RESOURCE
      $USER1$=/usr/lib/nagios/plugins
      $USER10$=mysqluser
    RESOURCE

    data = NagiosParser::Resource::Parser.parse(resource)
    pp data

This will print a data structure that looks like this.

    {"$USER10$"=>"mysqluser",
     "$USER1$"=>"/usr/lib/nagios/plugins"}

# Development

The parsers are based on the racc parser generator. racc is needed
at runtime, but that should be no problem since it's included in the
Ruby standard library.

To modify the parsers you have to modify the `.y` files and regenerate
the Ruby files afterwards. There are two rake tasks to help with that.

* `rake parser::status`
* `rake parser::object`
* `rake parser::config`
* `rake parser::resource`

The bundler gem is used to handle the development dependencies.
Run `bundle install` to install them.

Please let me know if you have any questions or if you run into any
problems.

# Contribute

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

# Copyright

Copyright (c) 2010 Bernd Ahlers. See LICENSE for details.
