# encoding: utf-8
require 'simplecov'
SimpleCov.command_name 'cucumber'
SimpleCov.start

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test, :development

ENV['TEST'] = 'true'
ENV['AUTOLOAD_SPROCKETS'] = 'false'

PROJECT_ROOT_PATH = File.expand_path('../../../', __FILE__)
