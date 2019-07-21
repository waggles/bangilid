# frozen_string_literal: true

require 'spec_helper'

describe Bangilid do
  it 'solves the smallest problem' do
    map = Bangilid::MapMatrix.new.tap do |new_map|
      new_map.insert([4, 8, 7])
      new_map.insert([2, 5, 9])
    end

    # [9,5,2]
    expect(Bangilid.solve_from_map(map)).to eq [3, 7]
  end

  it 'solves the example problem' do
    map = Bangilid::MapMatrix.new.tap do |new_map|
      new_map.insert([4, 8, 7, 3])
      new_map.insert([2, 5, 9, 3])
      new_map.insert([6, 3, 2, 5])
      new_map.insert([4, 4, 1, 6])
    end

    # [9,5,3,2,1]
    expect(Bangilid.solve_from_map(map)).to eq [5, 8]
  end

  # This covers the given test case and therefore takes a while, so it is
  # skipped by default.
  xit 'solves the full problem' do
    map = generate_map

    # [1422, 1412, 1316, 1304, 1207, 1162, 965, 945, 734, 429, 332, 310, 214, 143, 0]
    expect(Bangilid.solve_from_map(map)).to eq [15, 1422]
  end

  def generate_map
    first_line_data = File.open('spec/full_dataset.txt', &:readline).split

    max_rows = first_line_data.first.to_i
    max_columns = first_line_data.last.to_i

    Bangilid::MapMatrix.new.tap do |map_matrix|
      File.open('spec/full_dataset.txt').each_with_index do |line, line_number|
        next if line_number.zero?
        break if line_number > max_rows

        map_matrix.insert(
          line.split.first(max_columns).map(&:to_i)
        )
      end
    end
  end
end
