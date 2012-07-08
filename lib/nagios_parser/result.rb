module NagiosParser
  class Result
    def initialize(options = {})
      @options = options
      @result = {}
    end

    def []=(key, value)
      if multi_value?(key)
        (@result[key] ||= []) << value
      else
        @result[key] = value
      end
    end

    def [](key)
      @result[key]
    end

    def to_hash
      @result.dup
    end

    private

    def multi_value?(key)
      Array(@options[:multi_value]).include?(key)
    end
  end
end
