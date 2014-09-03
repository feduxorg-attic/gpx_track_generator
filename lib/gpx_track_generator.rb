require 'thor'
require 'nokogiri'
require 'thor/actions'
require 'active_support/core_ext/string/strip'
require 'fedux_org_stdlib/logging/logger'
require 'fedux_org_stdlib/core_ext/array/list'

require 'gpx_track_generator/version'
require 'gpx_track_generator/logger'
require 'gpx_track_generator/main'
require 'gpx_track_generator/gpx_file'
require 'gpx_track_generator/runner'
require 'gpx_track_generator/track'
require 'gpx_track_generator/api'
require 'gpx_track_generator/pretty'

# Track generator
module GpxTrackGenerator
end
