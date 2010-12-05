#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.6
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'strscan'

module NagiosParser
  module Status
    class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 39)

def create_token(string)
  result = []
  inside = false
  scanner = StringScanner.new(string)

  until scanner.empty?
    case
    when scanner.scan(/\s+/)
      # ignore whitespace
    when scanner.scan(/#[^\n]*/)
      # ignore comments
    when (!inside and match = scanner.scan(/\w+/))
      result << [match, match]
    when match = scanner.scan(/\{/)
      inside = true
      result << [:OPEN, nil]
    when match = scanner.scan(/\}/)
      inside = false
      result << [:CLOSE, nil]
    when match = scanner.scan(/\w+\s*\=/)
      result << [:KEY, match.chop.gsub(/\s+$/, '')]
    when (inside and match = scanner.scan(/\d+$/))
      result << [:VALUE, match.to_i]
    when (inside and match = scanner.scan(/[^\n\}]+/))
      result << [:VALUE, match.gsub(/\s+$/, '')]
    else
      raise "Can't tokenize <#{scanner.peek(10)}>"
    end
  end

  result << [false, false]
end

attr_accessor :token

def parse(string)
  @result = {}
  @token = create_token(string)
  do_parse
  @result
end

def next_token
  @token.shift
end
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    11,    19,    15,    13,    15,    18,     6,     7,     8,     9,
    10,     1,     2,     6,     7,     8,     9,    10,     1,     2,
    14 ]

racc_action_check = [
     3,    16,    16,     5,    13,    15,     3,     3,     3,     3,
     3,     3,     3,     0,     0,     0,     0,     0,     0,     0,
    11 ]

racc_action_pointer = [
     7,   nil,   nil,     0,   nil,     1,   nil,   nil,   nil,   nil,
   nil,    20,   nil,     0,   nil,     0,    -2,   nil,   nil,   nil,
   nil ]

racc_action_default = [
   -15,    -9,   -10,   -15,    -1,   -15,    -4,    -5,    -6,    -7,
    -8,   -15,    -2,   -15,    21,   -13,   -15,   -11,   -14,    -3,
   -12 ]

racc_goto_table = [
    17,     4,    16,    20,    12,     3 ]

racc_goto_check = [
     5,     2,     4,     5,     2,     1 ]

racc_goto_pointer = [
   nil,     5,     1,   nil,   -11,   -13 ]

racc_goto_default = [
   nil,   nil,   nil,     5,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 14, :_reduce_none,
  2, 14, :_reduce_none,
  4, 15, :_reduce_3,
  1, 16, :_reduce_none,
  1, 16, :_reduce_none,
  1, 16, :_reduce_none,
  1, 16, :_reduce_none,
  1, 16, :_reduce_none,
  1, 16, :_reduce_none,
  1, 16, :_reduce_none,
  1, 17, :_reduce_none,
  2, 17, :_reduce_12,
  1, 18, :_reduce_13,
  2, 18, :_reduce_14 ]

racc_reduce_n = 15

racc_shift_n = 21

racc_token_table = {
  false => 0,
  :error => 1,
  :OPEN => 2,
  :CLOSE => 3,
  :KEY => 4,
  :VALUE => 5,
  "hostcomment" => 6,
  "servicestatus" => 7,
  "info" => 8,
  "programstatus" => 9,
  "hoststatus" => 10,
  "contactstatus" => 11,
  "servicecomment" => 12 }

racc_nt_base = 13

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "OPEN",
  "CLOSE",
  "KEY",
  "VALUE",
  "\"hostcomment\"",
  "\"servicestatus\"",
  "\"info\"",
  "\"programstatus\"",
  "\"hoststatus\"",
  "\"contactstatus\"",
  "\"servicecomment\"",
  "$start",
  "types",
  "type",
  "type_names",
  "assignments",
  "assignment" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

module_eval(<<'.,.,', 'parser.y', 11)
  def _reduce_3(val, _values, result)
            @result[val[0]] ||= []
	@result[val[0]] << val[2]
      
    result
  end
.,.,

# reduce 4 omitted

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

# reduce 10 omitted

# reduce 11 omitted

module_eval(<<'.,.,', 'parser.y', 22)
  def _reduce_12(val, _values, result)
            val[1].each do |key, value|
          val[0][key] = value
        end
        result = val[0]
      
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 29)
  def _reduce_13(val, _values, result)
     result = {val[0] => nil}
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 30)
  def _reduce_14(val, _values, result)
     result = {val[0] => val[1]} 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class Parser
    end   # module Status
  end   # module NagiosParser