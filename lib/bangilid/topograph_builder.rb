# frozen_string_literal: true

module Bangilid
  # Responsible for constructing a Topograph representation of a MapMatrix.
  # Contains knowledge only necessary during this process and is not needed once
  # the process is complete.
  class TopographBuilder
    def initialize(map_matrix)
      @map_matrix = map_matrix
      @location_map = {}
    end

    def build
      build_location_map
      link_all_locations
      Bangilid::Topograph.new(@location_map.values)
    end

    private

    def build_location_map
      @location_map.tap do |location_map|
        @map_matrix.each_with_coordinates do |altitude_value, coordinates|
          location_map[coordinates] = Bangilid::Location.new(altitude_value)
        end
      end
    end

    def link_all_locations
      @location_map.each do |coordinates, location|
        link_children(location, location_neighbor_coordinates(coordinates))
      end
    end

    def link_children(location, neighbor_coordinates)
      neighbor_locations = neighbor_coordinates.map { |coords| @location_map[coords] }
      location.link_children(neighbor_locations)
    end

    def location_neighbor_coordinates(coordinates)
      @map_matrix.neighbors_of(*coordinates)
    end
  end
end
