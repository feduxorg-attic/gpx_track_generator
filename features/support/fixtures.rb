# encoding: utf-8
module FeatureHelper
  # Helper for fixtures
  module Fixtures
    def fixtures_manager
      @fixtures_manager ||= FeduxOrgStdlib::FixturesManagement::FixturesManager.new

      @fixtures_manager.load_fixtures(File.expand_path('../../../fixtures', __FILE__))

      @fixtures_manager
    end
  end
end

World(FeatureHelper::Fixtures)
