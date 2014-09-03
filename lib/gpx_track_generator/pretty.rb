module GpxTrackGenerator
  module PrettyXml
    def human
      Nokogiri::XSLT(File.open(File.expand_path('../pretty.xslt', __FILE__))).apply_to self
    end
  end
end

class Nokogiri::XML::Node
  include GpxTrackGenerator::PrettyXml
end

