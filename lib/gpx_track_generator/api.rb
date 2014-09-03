# encoding: utf-8
module GpxTrackGenerator
  # Main api
  module Api
    def self.generate(input_files:, track_name:, output_file:, reverse: false, reverse_waypoints: false, reverse_files: false, single_segment: false)
      files = input_files.map { |f| GpxFile.new(File.expand_path(f)) }
      track = Track.new(
        files,
        name: track_name,
        reverse_files: reverse || reverse_files,
        reverse_waypoints: reverse || reverse_waypoints,
        single_segment: single_segment
      )

      File.write(output_file, track.to_s)
    end
  end
end
