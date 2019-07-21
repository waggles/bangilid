# frozen_string_literal: true

module Bangilid
  # Represents a single point on a map, topograph, or path.
  class Location
    attr_reader(
      :altitude,
      :children,
      :best_candidate
    )

    def initialize(altitude)
      @altitude = altitude
      @peak = false
      @children = nil
      @best_candidate = nil
    end

    def lower_than?(other_altitude)
      altitude < other_altitude
    end

    def peak?
      @peak
    end

    def link_children(neighbor_locations)
      @children = neighbor_locations.select { |location| location.lower_than?(altitude) }
      @peak = (@children.length == neighbor_locations.length)
    end

    def calculate_paths
      return @best_candidate = Bangilid::Path.new([self]) if children.empty?

      candidate_paths = children.map { |child_location| path_down(child_location) }
      @best_candidate = candidate_paths.max
    end

    private

    def path_down(child_location)
      Bangilid::Path.create_with_new_peak(self, child_location.best_candidate)
    end
  end
end
