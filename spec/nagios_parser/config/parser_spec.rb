require 'spec_helper'
require 'nagios_parser/config/parser'

describe NagiosParser::Config::Parser do
  let(:parser) { NagiosParser::Config::Parser.new }

  describe ".parse" do
    it "returns a hash of macro definitions" do
      data = parser.parse('log_file=/var/log/nagios3/nagios.log')
      data['log_file'].should == '/var/log/nagios3/nagios.log'
    end
  end

  describe "#create_token" do
    context "given a valid string" do
      it "creates a valid token list" do
        string = <<-RUBY
          # LOG FILE
          # This is the main log file where service and host events are logged
          # for historical purposes.  This should be the first option specified 
          # in the config file!!!

          log_file=/var/log/nagios3/nagios.log
          object_cache_file=/var/cache/nagios3/objects.cache

          nagios_group=nagios

          status_update_interval=10
        RUBY

        parser.create_token(string).should == [
          [:KEY, 'log_file'], [:VALUE, '/var/log/nagios3/nagios.log'],
          [:KEY, 'object_cache_file'], [:VALUE, '/var/cache/nagios3/objects.cache'],
          [:KEY, 'nagios_group'], [:VALUE, 'nagios'],
          [:KEY, 'status_update_interval'], [:VALUE, 10],
          [false, false]
        ]
      end
    end
  end

  describe "#next_token" do
    it "shifts the next element off the token list" do
      parser.token = [:one, :two, :three]
      parser.next_token
      parser.next_token.should == :two
    end
  end

  describe "#parse" do
    context "with a valid string" do
      it "returns a hash of config key value pairs" do
        string = <<-RUBY
          external_command_buffer_slots=4096


          # LOCK FILE
          # This is the lockfile that Nagios will use to store its PID number
          # in when it is running in daemon mode.

          lock_file=/var/run/nagios3/nagios3.pid
          event_broker_options=-1

          cfg_dir=/etc/nagios/config1
          cfg_dir=/etc/nagios/config2
          cfg_dir=/etc/nagios/config3

          cfg_file=/etc/nagios/file1
          cfg_file=/etc/nagios/file2
        RUBY

        data = parser.parse(string)
        data['external_command_buffer_slots'].should == 4096
        data['lock_file'].should == '/var/run/nagios3/nagios3.pid'
        data['event_broker_options'].should == -1
        data['cfg_dir'].should == [
          '/etc/nagios/config1',
          '/etc/nagios/config2',
          '/etc/nagios/config3'
        ]
        data['cfg_file'].should == [
          '/etc/nagios/file1',
          '/etc/nagios/file2'
        ]
      end
    end

    context "with an invalid config" do
      it "will raise an exception" do
        expect {
          parser.parse('$foo=bar')
        }.to raise_error
      end
    end
  end
end
