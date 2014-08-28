# encoding: utf-8
require 'aruba/api'
require 'aruba/reporting'

# Spec Helpers
module SpecHelper
  # Helpers for aruba
  module Aruba
    include ::Aruba::Api

    def dirs
      @dirs ||= %w(tmp rspec)
    end

    def absolute_path(*args)
      in_current_dir { File.expand_path File.join(*args) }
    end

    def _create_file(*args)
      super

      args.first
    end

    def create_dir(*args)
      super

      args.first
    end

    def touch_file(file_name)
      in_current_dir do
        file_name = File.expand_path(file_name)
        _mkdir(File.dirname(file_name))
        FileUtils.touch file_name
      end

      file_name
    end
  end
end

RSpec.configure do |c|
  c.include SpecHelper::Aruba
  c.before :each do
    clean_current_dir
    restore_env
  end
end
