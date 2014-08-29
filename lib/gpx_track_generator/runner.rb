# encoding: utf-8
module GpxTrackGenerator
  # Runner
  class Runner < Thor
    option :file, default: 'track.gpx', desc: 'GPX track file name'
    option :name, default: 'Track #1', required: true, desc: 'Name for track'
    argument :input_files, type: :array, desc: 'GPX track or route files'

    desc 'generate', 'Generate gpx track'
    def generate
      Api.generate(input_files: input_files, track_name: options[:name], output_file: options[:file])
    end

    default_command :generate
  end
end
