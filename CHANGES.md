nagios\_parser - ChangeLog
==========================

# 1.3.0 (2013-03-23)
* Support multiple values for `cfg_file` and `cfg_dir` options.
* Loose grammar to support more nagios configuration files. (alisonrosewarne)

# 1.2.2 (2011-10-22)
* Unbreak on Ruby 1.9.x.

# 1.2.1 (2011-06-22)
* Apply original diff from Mitsuru to strip comments.
  This catches more inline comments.

# 1.2.0 (2011-06-20)
* Add NagiosParser::Resource parser to parse Nagios resource
  macro files.
* Add NagiosParser::Config parser to parse the Nagios main
  configuration file.
* Ignore inline comments starting with ';' in the object
  configuration files.

# 1.1.0 (2011-01-09)
* Remove hardcoded status types to make the parser less strict.
* More Nagios 2.x/3.x status types. (mariussturm)

# 1.0.0 (2010-12-16)
* Initial release
