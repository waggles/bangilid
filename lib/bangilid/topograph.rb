# frozen_string_literal: true

require 'tsort'

module Bangilid
  # Represents all location data in a connected, topographically sortable graph
  class Topograph
    include TSort

    def tsort_each_node(&block)
      @location_graph.each(&block)
    end

    def tsort_each_child(location, &block)
      location.children.each(&block)
    end

    attr_reader :location_graph

    def initialize(location_graph)
      @location_graph = location_graph
    end

    def steepest_long_path
      @steepest_long_path ||= select_steepest_long_path
    end

    private

    def select_steepest_long_path
      calculate_all_paths
      peaks.map(&:best_candidate).max
    end

    def calculate_all_paths
      tsort.each(&:calculate_paths)
    end

    def peaks
      @location_graph.keep_if(&:peak?)
    end
  end
end
