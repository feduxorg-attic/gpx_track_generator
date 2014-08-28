# encoding: utf-8

# Test helpers
# Spec Helpers
module SpecHelper
  # Helpers for ci
  module Ci
    def ci?
      ENV.key?('TRAVIS_CI') || ENV.key?('CI')
    end
  end
end

RSpec.configure do |c|
  c.include SpecHelper::Ci
end
