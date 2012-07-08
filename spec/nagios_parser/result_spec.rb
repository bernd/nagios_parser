require 'spec_helper'
require 'nagios_parser/result'

describe NagiosParser::Result do
  let(:result) { described_class.new }

  it "sets a key value pair" do
    result['foo'] = 'bar'

    result['foo'].should == 'bar'
  end

  context "with multi_value option set" do
    context "and a single value for a multi value key" do
      it "returns a list with one value" do
        result = described_class.new(:multi_value => %w{foo})
        result['foo'] = 'bar'

        result['foo'].should == ['bar']
      end
    end

    context "and multiple values for a multi value key" do
      it "returns a list with all values" do
        result = described_class.new(:multi_value => %w{eek})
        result['eek'] = 'foo'
        result['eek'] = 'bar'

        result['eek'].should == ['foo', 'bar']
      end
    end
  end

  context "without multi_value options set" do
    context "and multiple values for the same key" do
      it "returns the last value" do
        result['baz'] = 'foo'
        result['baz'] = 'bar'

        result['baz'].should == 'bar'
      end
    end
  end

  describe "#to_hash" do
    it "returns a hash representation of the result" do
      result['foo'] = ['bar', 'baz']
      result['one'] = 1

      result.to_hash.should == {'foo' => ['bar', 'baz'], 'one' => 1}
    end
  end
end
