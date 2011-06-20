nagios_parser - ChangeLog
=========================

# 1.2.0
* Add NagiosParser::Resource parser to parse Nagios resource
  macro files.
* Add NagiosParser::Config parser to parse the Nagios main
  configuration file.
* Ignore inline comments starting with ';' in the object
  configuration files.

# 1.1.0
* Remove hardcoded status types to make the parser less strict.
* More Nagios 2.x/3.x status types. (mariussturm)

# 1.0.0
* Initial release
