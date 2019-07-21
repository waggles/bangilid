# frozen_string_literal: true

module Bangilid
  # Represents the initial stage of map data as defined in the problem
  # statement. Exists only to be used as a reference when building a Topograph.
  class MapMatrix
    def self.four_way_coordinates(row_idx, col_idx)
      [
        [row_idx - 1, col_idx],
        [row_idx, col_idx - 1],
        [row_idx, col_idx + 1],
        [row_idx + 1, col_idx]
      ]
    end

    def initialize
      @matrix = []
    end

    def insert(row)
      @matrix << row
    end

    def neighbors_of(row_idx, col_idx)
      MapMatrix.four_way_coordinates(row_idx, col_idx).keep_if do |coordinates|
        in_bounds?(*coordinates)
      end
    end

    def each_with_coordinates(&_block)
      @matrix.each_with_index do |row, row_idx|
        row.each_with_index do |column_value, col_idx|
          yield column_value, [row_idx, col_idx]
        end
      end
    end

    private

    def in_bounds?(row_idx, col_idx)
      [row_idx, col_idx].all? { |index| index >= 0 } &&
        row_idx < @matrix.size &&
        col_idx < @matrix.first.size
    end
  end
end
