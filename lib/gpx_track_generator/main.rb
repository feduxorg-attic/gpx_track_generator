# encoding: utf-8
module GpxTrackGenerator
  @logger = GpxTrackGenerator::Logger.new

  class << self
    attr_reader :logger
  end
end
