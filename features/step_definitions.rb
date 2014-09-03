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

Then(/^the gpx file named "(.*?)" should have "(.*?)" track nodes$/) do |file, count|
  in_current_dir do
    expect(Nokogiri::XML(File.open(file)).css('trkpt').to_a.size).to eq count.to_i
  end
end

Then(/^a gpx file named "(.*?)" should exist(?: with "(.*?)" track nodes)?$/) do |file, count|
  step %(a file named "#{file}" should exist)
  step %(the gpx file named "#{file}" should have "#{count}" track nodes) if count
end

Then(/^the gpx file "(.*?)" should contain:$/) do |file, content|
  step %(the file "#{file}" should contain:), content
end

Given(/^a converter script named "(.*?)" with$/) do |name, content|
  header = <<-EOS.strip_heredoc
    #!/usr/bin/env ruby
    # encoding: utf-8
    require 'gpx_track_generator'
  EOS
  content = header + content

  step %(a file named "#{name}" with mode "0755" and with:), content
end
