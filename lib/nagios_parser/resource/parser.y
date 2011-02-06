class NagiosParser::Resource::Parser
  token
    KEY VALUE

  rule
    assignments
      : assignment
      | assignments assignment
      ;
    assignment
      : KEY VALUE { @result[val[0]] = val[1] }
      ;
end

---- header
require 'strscan'

---- inner

def create_token(string)
  result = []
  scanner = StringScanner.new(string)

  until scanner.empty?
    case
    when scanner.scan(/\s+/)
      # ignore whitespace
    when scanner.scan(/#[^\n]*/)
      # ignore comments
    when match = scanner.scan(/\$\w+\$\s*\=/)
      result << [:KEY, match.chop.gsub(/\s+$/, '')]
    when match = scanner.scan(/[^\n]+/)
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
