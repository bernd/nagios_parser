require 'spec_helper'
require 'nagios_parser/resource/parser'

describe NagiosParser::Resource::Parser do
  let(:parser) { NagiosParser::Resource::Parser.new }

  describe ".parse" do
    it "returns a hash of macro definitions" do
      data = parser.parse('$USER1$=/usr/lib/nagios/plugins')
      data['$USER1$'].should == '/usr/lib/nagios/plugins'
    end
  end

  describe "#create_token" do
    context "given a valid string" do
      it "creates a valid token list" do
        string = <<-RUBY
          # This is the resource configuration
          $USER1$=/usr/lib/nagios/plugins
          $USER10$=mysqluser

          $USER30$ = /bin
        RUBY

        parser.create_token(string).should == [
          [:KEY, '$USER1$'], [:VALUE, '/usr/lib/nagios/plugins'],
          [:KEY, '$USER10$'], [:VALUE, 'mysqluser'],
          [:KEY, '$USER30$'], [:VALUE, '/bin'],
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
      it "returns a hash of resource macros" do
        string = <<-RUBY
          # This is the resource configuration
          $USER1$=/usr/lib/nagios/plugins
          $USER10$=mysqluser

          $USER30$ = /bin
        RUBY

        data = parser.parse(string)
        data['$USER1$'].should == '/usr/lib/nagios/plugins'
        data['$USER10$'].should == 'mysqluser'
        data['$USER30$'].should == '/bin'
      end
    end

    context "with invalid resource macro" do
      it "will raise an exception" do
        expect {
          parser.parse('foo=bar')
        }.to raise_error
      end
    end
  end
end
