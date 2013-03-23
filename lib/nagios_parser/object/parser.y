class NagiosParser::Object::Parser
  token
    DEFINE TYPE OPEN CLOSE KEY VALUE

  rule
    defines
      : define
      | defines define
      ;
    define
      : DEFINE TYPE OPEN assignments CLOSE {
        @result[val[1]] ||= []
        @result[val[1]] << val[3]
      }
      ;
    assignments
      : assignment
      | assignments assignment {
        val[1].each do |key, value|
          val[0][key] = value
        end
        result = val[0]
      }
      ;
    assignment
      : KEY VALUE { result = {val[0] => val[1]} }
      | KEY { result = {val[0] => nil } }
      ;
end

---- header
require 'strscan'

---- inner

private
def last_is_key?(list)
  list.last[0] == :KEY
end

public
def create_token(string)
  result = []
  inside = false
  inside_squigglies = false
  scanner = StringScanner.new(string)

  until scanner.empty?
    case
    when scanner.scan(/\s+/)
      # ignore whitespace
    when scanner.scan(/#[^\n]*/)
      # ignore comments
    when scanner.scan(/.*;[^\n]*/)
      # ignore inline comments
      r = scanner.matched.sub(/(.*);[^\n]*/, '\1')
      scanner.string = r + scanner.rest
      scanner.reset
    when scanner.scan(/define/)
      result << [:DEFINE, nil]
    when (!inside and match = scanner.scan(/\w+/))
      result << [:TYPE, match]
    when (!inside and match = scanner.scan(/\{/))
      inside = true
      result << [:OPEN, nil]
    when (match = scanner.scan(/\}/))
      inside = false
      result << [:CLOSE, nil]
    when (!last_is_key?(result) and match = scanner.scan(/\w+/))
      result << [:KEY, match.chomp.gsub(/\s+$/, '')]
    when (inside and match = scanner.scan(/\d+$/))
      result << [:VALUE, match.to_i]
    when (inside and match = scanner.scan(/.*\{.+\}.*/))
      result << [:VALUE, match.gsub(/\s+$/, '')]
    when (inside and match = scanner.scan(/[^\n\}]+/))
      # Make sure to ignore inline comments starting with ';'.
      result << [:VALUE, match.gsub(/\s+$/, '')]
    else
      raise "Can't tokenize <#{scanner.peek(10)}>"
    end
  end

  result << [false, false]
end

attr_accessor :token

def self.parse(string)
  new.parse(string)
end

def parse(string)
  @result = {}
  @token = create_token(string)
  do_parse
  @result
end

def next_token
  @token.shift
end
