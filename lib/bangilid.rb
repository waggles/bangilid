# frozen_string_literal: true

require_relative 'bangilid/map_matrix'
require_relative 'bangilid/path'
require_relative 'bangilid/location'
require_relative 'bangilid/topograph'
require_relative 'bangilid/topograph_builder'

# Top-level module for this library, see README for details.
module Bangilid
  def self.solve_from_map(map)
    graph = Bangilid::TopographBuilder.new(map).build

    path = graph.steepest_long_path

    [path.length, path.height]
  end
end
