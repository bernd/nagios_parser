require 'spec_helper'
require 'nagios_parser/object/parser'

describe NagiosParser::Object::Parser do
  let(:parser) { NagiosParser::Object::Parser.new }

  describe ".parse" do
    it "returns a hash of status types" do
      data = NagiosParser::Object::Parser.parse('define host { host_name foo }')
      data['host'].first['host_name'].should == 'foo'
    end
  end

  describe "#create_token" do
    context "given a valid string" do
      it "creates a valid token list" do
        string = <<-RUBY
          define host {
            host_name foo.example.com
            _plugin_path  /usr/lib64/nagios/plugins
          }
          define service {
            host_name   foo.example.com
            service_description SUPERD
            }
        RUBY

        parser.create_token(string).should == [
          [:DEFINE, nil],
          [:TYPE, 'host'],
          [:OPEN, nil],
          [:KEY, 'host_name'],
          [:VALUE, 'foo.example.com'],
          [:KEY, '_plugin_path'],
          [:VALUE, '/usr/lib64/nagios/plugins'],
          [:CLOSE, nil],
          [:DEFINE, nil],
          [:TYPE, 'service'],
          [:OPEN, nil],
          [:KEY, 'host_name'],
          [:VALUE, 'foo.example.com'],
          [:KEY, 'service_description'],
          [:VALUE, 'SUPERD'],
          [:CLOSE, nil],
          [false, false]
        ]
      end
    end
  end

  describe "#next_token" do
    it "returns shifts the next element off the token list" do
      parser.token = [:one, :two, :three]
      parser.next_token
      parser.next_token.should == :two
    end
  end

  describe "#parse" do
    context "with a valid string" do
      it "returns a hash of status types" do
        string = <<-RUBY
          define host {
            host_name foo.example.com
            notification_interval 40
          }
        RUBY

        data = parser.parse(string)
        data['host'].first['host_name'] == 'foo.example.com'
        data['host'].first['notification_interval'] == 40
      end
    end

    context "with an invalid status type" do
      it "will raise an exception" do
        expect {
          parser.parse('FooBar { info test }')
        }.to raise_error
      end
    end

    context "with invalid status data" do
      it "will raise an exception" do
        expect {
          parser.parse('define host { =test }')
        }.to raise_error
      end
    end
  end
end
