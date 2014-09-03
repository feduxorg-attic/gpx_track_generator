module GpxTrackGenerator
  # Prettify XML
  module PrettyXml
    # Make xml pretty
    def human
      Nokogiri::XSLT(File.open(File.expand_path('../pretty.xslt', __FILE__))).apply_to self
    end
  end
end

# Nokogiri
module Nokogiri
  # XML
  module XML
    # Node
    class Node
      include GpxTrackGenerator::PrettyXml
    end
  end
end
