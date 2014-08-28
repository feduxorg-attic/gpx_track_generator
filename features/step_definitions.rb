# encoding: utf-8

Before do
  @aruba_timeout_seconds = 120
  ENV['MM_ENV'] = 'development'

  step 'a mocked home directory'
end

# Clean environment
Around do |_, block|
  old_env = ENV.to_h

  block.call

  ENV.replace old_env
end

Given(/^a gpx file named "(.*?)"$/) do |file|
  in_current_dir do
    FileUtils.cp File.expand_path("../../fixtures/#{file}", __FILE__), file
  end
end

Then(/^a gpx file named "(.*?)" should exist$/) do |file|
  step %(a file named "#{file}" should exist)
end
