# Copyright (c) 2012 Ryan J. Geyer
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib', 'plugins', 'json', 'aws_keychain_plugin_json'))

describe AwsKeychain::Plugin::Json do
  context :initialize do
    it 'can be initalized with a hash of options' do
      lambda { AwsKeychain::Plugin::Json.new({'foo' => 'bar'}) }.should_not raise_error
    end
  end

  context :plugin_interface do
    it 'has an actions method' do
      AwsKeychain::Plugin::Json.new.methods.should include :actions
    end

    it 'actions returns an array' do
      AwsKeychain::Plugin::Json.new.actions.class.should == Array
    end

    it 'has a short_name method' do
      AwsKeychain::Plugin::Json.new.methods.should include :short_name
    end
  end

  context :show do
    it 'returns a properly configured string' do
      key = {
        "key" => "key",
        "secret" => "secret"
      }
      json = AwsKeychain::Plugin::Json.new
      json.show(key).should == JSON.pretty_generate(key)
    end
  end
end