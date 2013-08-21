# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'capistrano/novelys/version'

Gem::Specification.new do |s|
  s.name         = 'capistranovelys'
  s.version      = Capistrano::Novelys::VERSION
  s.authors      = ['Kevin Soltysiak']
  s.email        = 'kevin.soltysiak@novelys.com'
  s.homepage     = 'https://github.com/novelys/capistranovelys'
  s.summary      = 'Capistrano recipes for novelys'
  s.description  = 'Capistrano recipes in use at novelys'
  s.license      = 'MIT'

  s.files        = `git ls-files`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'

  s.add_dependency 'capistrano', '~> 2.15.0'
  s.add_dependency 'sushi',      '~> 0.0.2'
end
