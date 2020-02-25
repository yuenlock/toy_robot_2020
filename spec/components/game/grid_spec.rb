require './components/game/grid.rb'

RSpec.describe Game::Grid do
  let(:grid) { described_class.new(size_x: 5, size_y: 5) }

  describe '#valid_position?' do
    context 'within grid' do
      let(:good_position) { instance_double 'Game::Position', x: 1, y: 1 }

      it { expect(grid.valid_position?(good_position)).to eq true }
    end

    context 'outside of grid' do
      let(:position_neg_x) { instance_double 'Game::Position', x: -1, y:  1 }
      let(:position_neg_y) { instance_double 'Game::Position', x:  1, y: -1 }
      let(:position_out_x) { instance_double 'Game::Position', x:  5, y:  1 }
      let(:position_out_y) { instance_double 'Game::Position', x:  1, y:  5 }

      it { expect(grid.valid_position?(position_neg_x)).to eq false }
      it { expect(grid.valid_position?(position_neg_y)).to eq false }
      it { expect(grid.valid_position?(position_out_x)).to eq false }
      it { expect(grid.valid_position?(position_out_x)).to eq false }
    end
  end
end
