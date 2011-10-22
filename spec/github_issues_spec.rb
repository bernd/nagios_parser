require 'spec_helper'
require 'nagios_parser/object/parser'

describe "Github issues" do
  describe "#3" do
    it "can parse the user provided object config" do
      object = <<-__OBJ
define host{
        use              switch
        host_name   Foo-ibb
        alias            Foo iBootBar
        address       10.3.1.20
        hostgroups   iboots,Foo
        parents        Foo-modem
      }
      __OBJ

      out = NagiosParser::Object::Parser.parse(object)
      host = out['host'].first
      host['use'].should == 'switch'
      host['host_name'].should == 'Foo-ibb'
      host['alias'].should == 'Foo iBootBar'
      host['address'].should == '10.3.1.20'
      host['hostgroups'].should == 'iboots,Foo'
      host['parents'].should == 'Foo-modem'
    end
  end
end
