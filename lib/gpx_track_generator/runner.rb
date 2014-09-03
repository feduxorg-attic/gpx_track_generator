# encoding: utf-8
module GpxTrackGenerator
  # Runner
  class Runner < Thor
    option :file, default: 'track.gpx', desc: 'GPX track file name'
    option :name, default: 'Track #1', required: true, desc: 'Name for track'
    option :reverse, type: :boolean, default: false, desc: 'Reverse track (default: false)'
    option :reverse_waypoints, type: :boolean, default: false, desc: 'Reverse waypoints in tracks (default: false)'
    option :reverse_files, type: :boolean, default: false, desc: 'Reverse track files (default: false)'
    option :single_segment, type: :boolean, default: false, desc: 'Only one track segment for the whole track. Otherwise one segment for each input file (default: true)'
    argument :input_files, type: :array, desc: 'GPX track or route files'

    desc 'generate', 'Generate gpx track'
    def generate
      GpxTrackGenerator.logger.info "Generating GPX Track \"#{options[:file]}\" from #{input_files.to_list(last_separator: ' and ')}"

      Api.generate(
        input_files: input_files,
        track_name: options[:name],
        output_file: options[:file],
        reverse: options[:reverse],
        reverse_waypoints: options[:reverse_waypoints],
        reverse_files: options[:reverse_files],
        single_segment: options[:single_segment]
      )
    end

    default_command :generate
  end
end
