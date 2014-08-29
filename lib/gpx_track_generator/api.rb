# encoding: utf-8
module GpxTrackGenerator
  # Main api
  module Api
    def self.generate(input_files:, track_name:, output_file:, reverse: false)
      files = input_files.map { |f| GpxFile.new(File.expand_path(f)) }
      track = Track.new(files, name: track_name, reverse: reverse)

      File.write(output_file, track.to_s)
    end
  end
end
