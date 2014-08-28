# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gpx_track_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'gpx_track_generator'
  spec.version       = GpxTrackGenerator::VERSION
  spec.authors       = ['Max Meyer']
  spec.email         = ['dev@fedux.org']
  spec.summary       = 'Generate a gpx track from gpx tracks/routes'
  spec.homepage      = 'https://github.com/maxmeyer/gpx_track_generator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'activesupport'
end
