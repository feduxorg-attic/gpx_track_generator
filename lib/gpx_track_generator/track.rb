# encoding: utf-8
module GpxTrackGenerator
  # Track
  class Track
    private

    attr_reader :files

    public

    def initialize(files)
      @files = files
    end

    def to_s
      build_document
    end

    private

    def build_document
      document.child << metadata
      document.child << document.create_element('trk')

      files.each_with_object(document.css('trk').first) do |e, a|
        a << document.create_element('trkseg')
        node_set = Nokogiri::XML(File.open(e)).remove_namespaces!.css('rtept')
        node_set.each { |n| n.name = 'trkpt' }

        a.css('trkseg').last << node_set
      end

      document.to_s
    end

    def document
      Nokogiri::XML(
      <<-EOS.strip_heredoc
    <gpx xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="1.1" creator="Nokogiri" xmlns="http://www.topografix.com/GPX/1/1"></gpx>
      EOS
      )
    end

    def metadata
      Nokogiri::XML::DocumentFragment.parse <<-EOS.strip_heredoc
      <metadata>
        <desc>GPX file generated nokogiri</desc>
        <link href="http://nokogiri.org/">
          <text>Nokogiri</text>
        </link>
        <time>#{Time.now}</time>
      </metadata>
      EOS
    end
  end
end
