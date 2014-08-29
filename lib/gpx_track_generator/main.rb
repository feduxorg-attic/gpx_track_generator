# encoding: utf-8
# Main
module GpxTrackGenerator
  @logger = GpxTrackGenerator::Logger.new

  class << self
    attr_reader :logger
  end
end
