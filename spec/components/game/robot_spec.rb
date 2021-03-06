require './components/game/robot.rb'
require './components/game/errors.rb'

RSpec.describe Game::Robot do
  let(:grid) { instance_double 'Game::Grid' }
  let(:position_class) { class_double 'Game::Position' }
  let(:init_position) { instance_double 'Game::Position', x: 1, y: 1, facing: 1 }
  let(:new_position) { instance_double 'Game::Position',  x: 2, y: 2, facing: 2 }
  let(:robot) { described_class.new(grid: grid, position: init_position) }

  describe '#place' do
    context 'valid position' do
      before do
        allow(grid).to receive(:valid_position?).and_return true
        robot.place(position: init_position)
      end

      it 'sets the position' do
        expect(robot.current_position).to eq init_position
      end
    end

    context 'invalid position' do
      before do
        allow(grid).to receive(:valid_position?).and_return false
      end

      it 'raises error' do
        expect { robot.place(position: init_position) }.to raise_error Game::InvalidPlacementError
      end
    end
  end

  describe '#move' do
    context 'valid position' do
      before do
        allow(grid).to receive(:valid_position?).and_return true
        expect(init_position).to receive(:move).and_return new_position

        robot.move
      end

      it 'stays in place' do
        expect(robot.current_position).to eq new_position
      end
    end

    context 'bad position' do
      before do
        allow(grid).to receive(:valid_position?).with(new_position).and_return false
        expect(init_position).to receive(:move).and_return new_position

        robot.move
      end

      it 'stays in place' do
        expect(robot.current_position).to eq init_position
      end
    end
  end

  describe 'rotate' do
    before do
      allow(grid).to receive(:valid_position?).and_return true
    end

    describe '#left' do
      before do
        expect(init_position).to receive(:left).and_return new_position
        robot.left
      end

      it 'updates position' do
        expect(robot.current_position).to eq new_position
      end
    end

    describe '#right' do
      before do
        expect(init_position).to receive(:right).and_return new_position
        robot.right
      end

      it 'updates position' do
        expect(robot.current_position).to eq new_position
      end
    end
  end

  describe '#report' do
    context 'valid position' do
      let(:position_string) { '1,2,WEST' }
      before do
        allow(init_position).to receive(:report).and_return position_string
      end

      it { expect(robot.report).to eq position_string }
    end

    context 'bad position' do
      before do
        allow(robot).to receive(:current_position).and_return nil
      end

      it { expect { robot.report }.to raise_error(Game::InvalidPlacementError) }
    end
  end
end
