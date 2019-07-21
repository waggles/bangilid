# frozen_string_literal: true

require 'spec_helper'

describe Bangilid::MapMatrix do
  subject(:map_matrix) do
    described_class.new.tap do |matrix|
      matrix.insert([7, 8, 9])
      matrix.insert([4, 5, 6])
      matrix.insert([1, 2, 3])
    end
  end

  describe 'neighbor coordinates' do
    subject { map_matrix.neighbors_of(*coordinates) }

    context 'for origin coordinates' do
      let(:coordinates) { [0, 0] }
      it { is_expected.to contain_exactly([0, 1], [1, 0]) }
    end

    context 'for central coordinates' do
      let(:coordinates) { [1, 1] }
      it { is_expected.to contain_exactly([0, 1], [1, 0], [1, 2], [2, 1]) }
    end

    context 'for max coordinates' do
      let(:coordinates) { [2, 2] }
      it { is_expected.to contain_exactly([1, 2], [2, 1]) }
    end
  end

  describe 'iteration via each_with_coordinates' do
    it 'visits each value' do
      collected_data = {}
      map_matrix.each_with_coordinates do |value, coordinates|
        collected_data[coordinates] = value
      end

      expect(collected_data).to eq(
        [0, 0] => 7,
        [0, 1] => 8,
        [0, 2] => 9,
        [1, 0] => 4,
        [1, 1] => 5,
        [1, 2] => 6,
        [2, 0] => 1,
        [2, 1] => 2,
        [2, 2] => 3
      )
    end
  end
end
