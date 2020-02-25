require './components/game.rb'

RSpec.describe 'Borders' do
  let(:grid) { Game::Grid.new }
  let(:robot) { Game::Robot.new(grid: grid) }

  context 'place' do
    let(:invalid_x) { Game::Position.new(x: 9, y: 0, facing: 0) }
    let(:invalid_y) { Game::Position.new(x: 0, y: 9, facing: 0) }
    let(:invalid_facing) { Game::Position.new(x: 0, y: 0, facing: 9) }

    it 'raises error' do
      expect { robot.place(position: invalid_x) }.to raise_error(Game::InvalidPlacementError)
      expect { robot.place(position: invalid_y) }.to raise_error(Game::InvalidPlacementError)
    end

    it 'calculates facing' do
      robot.place(position: invalid_facing)
      expect(robot.current_position.facing).to eq 1
    end
  end

  context 'move' do
    let(:top_right_north) { Game::Position.new(x: grid.max_x, y: grid.max_y, facing: 0) }
    let(:top_right_east)  { Game::Position.new(x: grid.max_x, y: grid.max_y, facing: 1) }
    let(:bot_left_south)  { Game::Position.new(x: 0, y: 0, facing: 2) }
    let(:bot_left_west)   { Game::Position.new(x: 0, y: 0, facing: 3) }

    context 'outside of borders' do
      it 'stays in place' do
        robot.place(position: top_right_north)
        robot.move
        expect(robot.current_position).to eq top_right_north
      end

      it 'raises errors' do
        robot.place(position: top_right_east)
        robot.move
        expect(robot.current_position).to eq top_right_east
      end

      it 'raises errors' do
        robot.place(position: bot_left_south)
        robot.move
        expect(robot.current_position).to eq bot_left_south
      end

      it 'raises errors' do
        robot.place(position: bot_left_west)
        robot.move
        expect(robot.current_position).to eq bot_left_west
      end
    end
  end
end
