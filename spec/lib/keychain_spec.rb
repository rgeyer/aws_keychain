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

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'keychain'))

describe AwsKeychain::Keychain do
  context :initialize do
    it 'raises an exception if neither keychain_file or keychain_data was supplied' do
      lambda { AwsKeychain::Keychain.new }.should raise_error ArgumentError
    end

    it 'raises an exception if the keychain file does not exist' do
      lambda {
        AwsKeychain::Keychain.new(:keychain_file =>'foobarbaz.json')
      }.should raise_error Errno::ENOENT, 'No such file or directory - foobarbaz.json'
    end
  end

  context :list do
    it 'lists all keys' do
      keychain_data = {
        'key1' => {},
        'key2' => {}
      }

      keychain = AwsKeychain::Keychain.new(:keychain_data => keychain_data)

      keychain.list.should == keychain_data.keys
    end
  end

  context :operators do
    it 'implements an array style operator override' do
      keychain_data = {
        'key1' => {},
        'key2' => {}
      }

      keychain = AwsKeychain::Keychain.new(:keychain_data => keychain_data)

      keychain['key1'].should == keychain_data['key1']
    end
  end
end