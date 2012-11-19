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

require 'json'

module AwsKeychain
  class Keychain

    attr_accessor :keychain

    # Initializes a new keychain from the specified keychain file
    #
    # @param [Hash] options A hash of options for the class where the keys are one of
    #   :keychain_file relative or absolute path to a json file containing the keychain data
    #   :keychain_data a hash containing the keychain data where keys are the name of the credential
    #     and values are a hash with any keys ("key" and "secret" are required keys)
    def initialize(options={})
      unless options.has_key?(:keychain_file) || options.has_key?(:keychain_data)
        raise ArgumentError, 'Either a keychain_file or keychain_data is required to create a new keychain class'
      end

      @keychain = options[:keychain_data] || JSON.parse(IO.read(options[:keychain_file]))

      # TODO: Validate that the hash is correct.
    end

    # Lists the names of all keys in the keychain
    #
    # @return [Array] The names of all keys in the keychain
    def list
      @keychain.keys
    end

  end
end