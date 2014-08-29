# encoding: utf-8
module GpxTrackGenerator
  class GpxFile

    attr_reader :path

    def initialize(path)
      @path = path
    end

    # Return nodes
    def nodes
      document = Nokogiri::XML('')
      node_set = Nokogiri::XML::NodeSet.new(document)

      node_set += extract_route_nodes unless extract_route_nodes.empty?
      node_set += extract_track_nodes unless extract_track_nodes.empty?

      node_set
    end

    private

    def extract_route_nodes
      node_set = Nokogiri::XML(File.open(path)).remove_namespaces!.css('rtept')
      node_set.each { |n| n.name = 'trkpt' }

      node_set
    end

    def extract_track_nodes
      node_set = Nokogiri::XML(File.open(path)).remove_namespaces!.css('trkpt')
      node_set.each { |n| n.name = 'trkpt' }

      node_set
    end
  end
end
