# encoding: utf-8
module GpxTrackGenerator
  # Track
  class Track
    private

    attr_reader :files, :name

    public

    def initialize(files, name:)
      @files = files
      @name = name
    end

    def to_s
      build_document
    end

    private

    def creator
      'gpx_track_generator'
    end

    def creator_url
      'https://github.com/maxmeyer/gpx_track_generator'
    end

    def build_document
      document.child << metadata

      document.child << document.create_element('trk')
      document.css('trk').first << document.create_element('name')
      document.css('name').first.content = name

      files.each_with_object(document.css('trk').first) do |e, a|
        a << "<!-- #{e.file_name} -->"
        a << document.create_element('trkseg')
        a.css('trkseg').last << e.nodes
      end

      document.human
    end

    def document
      @document ||= Nokogiri::XML(
      <<-EOS.strip_heredoc
    <gpx xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="1.1" creator="#{creator}" xmlns="http://www.topografix.com/GPX/1/1"></gpx>
      EOS
      )
    end

    def metadata
      @metadata ||= Nokogiri::XML::DocumentFragment.parse <<-EOS.strip_heredoc
      <metadata>
        <desc>GPX file generated by #{creator}</desc>
        <link href="#{creator_url}">
          <text>#{creator}</text>
        </link>
        <time>#{Time.now}</time>
      </metadata>
      EOS
    end
  end
end
