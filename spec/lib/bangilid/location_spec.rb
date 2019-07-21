# frozen_string_literal: true

require 'spec_helper'

describe Bangilid::Location do
  let(:altitude) { 59849 }
  subject(:location) { described_class.new(altitude) }

  describe 'linking a neighbor location' do
    let(:neighbor_location) { described_class.new(neighbor_altitude) }

    before { location.link_children([neighbor_location]) }

    context 'when neighbor is below self' do
      let(:neighbor_altitude) { altitude - 1 }

      describe '#peak?' do
        subject { location.peak? }
        it { is_expected.to be_truthy }
      end

      describe 'linked children' do
        subject { location.children }
        it { is_expected.to eq([neighbor_location]) }
      end
    end

    context 'when neighbor is above self' do
      let(:neighbor_altitude) { altitude + 1 }

      describe '#peak?' do
        subject { location.peak? }
        it { is_expected.not_to be_truthy }
      end

      describe 'linked children' do
        subject { location.children }
        it { is_expected.to be_empty }
      end
    end
  end

  describe 'calculating paths' do
    before do
      neighbor_locations.each { |location| location.link_children([]) }
      neighbor_locations.each(&:calculate_paths)
      location.link_children(neighbor_locations)
      location.calculate_paths
    end

    describe 'best candidate' do
      subject { location.best_candidate.to_a }

      context 'when there are no paths down from this location' do
        let(:neighbor_locations) { [] }
        it { is_expected.to eq([altitude]) }
      end

      context 'when one option is steeper than the other' do
        let(:steep_drop_location) { described_class.new(altitude - 100) }
        let(:shallow_drop_location) { described_class.new(altitude - 10) }
        let(:neighbor_locations) { [steep_drop_location, shallow_drop_location] }

        it { is_expected.to eq([altitude, steep_drop_location.altitude]) }
      end
    end
  end
end
