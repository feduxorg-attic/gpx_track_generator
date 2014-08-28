# encoding: utf-8

# Test helpers
module FeatureHelper
  # Helpers for ci
  module Ci
    def ci?
      ENV.key?('TRAVIS_CI') || ENV.key?('CI')
    end
  end
end

World(FeatureHelper::Ci)
