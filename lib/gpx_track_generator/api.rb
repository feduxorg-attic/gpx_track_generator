# encoding: utf-8
module GpxTrackGenerator
  # Main api
  module Api
    def self.generate(input_files:, track_name:, output_file:, reverse: false, single_segment: true)
      files = input_files.map { |f| GpxFile.new(File.expand_path(f)) }
      track = Track.new(files, name: track_name, reverse: reverse, single_segment: single_segment)

      File.write(output_file, track.to_s)
    end
  end
end
