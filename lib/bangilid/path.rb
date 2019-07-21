# frozen_string_literal: true

module Bangilid
  # Represents a path through the graph, and thus a potential "solution".
  class Path
    include Comparable

    attr_reader :location_array

    def self.create_with_new_peak(peak_location, path)
      new([peak_location] + path.location_array)
    end

    def initialize(location_array)
      @location_array = location_array
    end

    def height
      @height ||= @location_array.first.altitude - @location_array.last.altitude
    end

    def length
      @length ||= @location_array.length
    end

    def bottom
      @bottom ||= @location_array.last.altitude
    end

    def <=>(other)
      better_path_than?(other) ? 1 : -1
    end

    def to_a
      @location_array.map(&:altitude)
    end

    private

    def better_path_than?(other)
      longer_than?(other) ||
        same_length_but_higher_drop?(other) ||
        same_length_and_height_but_finishes_lower?(other)
    end

    def longer_than?(other)
      length > other.length
    end

    def same_length_but_higher_drop?(other)
      higher_than = (height > other.height)

      same_length?(other) && higher_than
    end

    def same_length_and_height_but_finishes_lower?(other)
      same_height = (height == other.height)
      finishes_lower = (bottom < other.bottom)

      same_length?(other) && same_height && finishes_lower
    end

    def same_length?(other)
      length == other.length
    end
  end
end
