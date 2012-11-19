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
require 'json'

aws_keychain_binfile = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "bin", "aws_keychain"))

describe "AWS Keychain Binary" do
  before(:each) do
    @tmpfile = File.join("/tmp", "keychain-#{Time.now.to_i}.json")
    File.open(@tmpfile, 'w') do |file|
      file.write({"foo" => {}, "bar" => {}, "baz" => {}}.to_json)
    end
  end

  after(:each) do
    File.delete(@tmpfile)
  end

  context :list do
    it 'honors quiet mode' do
      `#{aws_keychain_binfile} --keychain="#{@tmpfile}"  --list-keys`.should include "INFO -- : All available keys"
      `#{aws_keychain_binfile} --keychain="#{@tmpfile}"  --list-keys --quiet`.should == <<EOF
foo
bar
baz
EOF
    end
  end

  context :show_actions do
    it 'honors quiet mode' do
      `#{aws_keychain_binfile} --list-actions --quiet`.should_not include "INFO -- : All available actions listed below"
    end

    it 'has at least the json-show action' do
      `#{aws_keychain_binfile} --list-actions`.should include "json-show"
    end
  end

  context :action do
    it 'exits with exception when invalid action is specified' do
      `#{aws_keychain_binfile} --keychain="#{@tmpfile}" --action="foo-bar-baz"`.should include "The action foo-bar-baz is invalid"
      $?.exitstatus.should == 1
    end

    it 'exits with exception when unparsable action is specified' do
      `#{aws_keychain_binfile} --keychain="#{@tmpfile}" --action="not in the right format"`.should include "The action not in the right format is invalid"
      $?.exitstatus.should == 1
    end
  end
end