Gem::Specification.new do |gem|
  gem.name = "aws_keychain"
  gem.version = "0.0.2"
  gem.homepage = "https://github.com/rgeyer/aws_keychain"
  gem.license = "MIT"
  gem.summary = %Q{Stores AWS Creds and can be used to spit those creds out into useful file formats for AWS CLI tools}
  gem.description = gem.summary
  gem.email = "me@ryangeyer.com"
  gem.authors = ["Ryan J. Geyer"]
  gem.executables << "aws_keychain"

  gem.add_dependency('trollop', '~> 1.16')
  gem.add_dependency('json', '~> 1.7')

  gem.files = Dir.glob("{lib,bin}/**/*") + ["LICENSE.txt", "README.rdoc"]
end