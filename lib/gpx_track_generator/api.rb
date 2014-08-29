# encoding: utf-8
module GpxTrackGenerator
  module Api
    def self.generate(input_files:, track_name:, output_file:)
      files = input_files.map { |f| GpxFile.new(File.expand_path(f)) }
      track = Track.new(files, name: track_name)

      File.write(output_file, track.to_s)
    end
  end
end
