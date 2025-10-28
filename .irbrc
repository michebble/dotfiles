require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'awesome_print'
  gem 'irb-theme-dracula'
end

require 'awesome_print'
require "irb/theme/dracula/light"

AwesomePrint.defaults = {indent: -2}
AwesomePrint.irb!

IRB.conf[:USE_AUTOCOMPLETE] = true
