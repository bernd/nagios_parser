class NagiosParser::Status::Parser
  token
    TYPE OPEN CLOSE KEY VALUE

  rule
    types
      : type
      | types type
      ;
    type
      : TYPE OPEN assignments CLOSE {
        @result[val[0]] ||= []
	@result[val[0]] << val[2]
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
      : KEY { result = {val[0] => nil}}
      | KEY VALUE { result = {val[0] => val[1]} }
      ;
end

---- header
require 'strscan'

---- inner

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
      result << [:TYPE, match]
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
