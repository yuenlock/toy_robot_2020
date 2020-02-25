require './components/game.rb'

RSpec.describe 'RobotControl' do
  let(:grid) { Game::Grid.new }
  let(:position) { Game::Position.new(x: 1, y: 2, facing: 0) }
  let(:robot) { Game::Robot.new(grid: grid, position: position) }

  subject { Game::RobotControl.call(**command_args) }

  context 'place, move' do
    let(:command_args) { { robot: robot, commands: ['PLACE 0,1,NORTH', 'MOVE', 'REPORT'] } }

    it 'sends commands' do
      expect(subject).to eq ['0,2,NORTH']
    end
  end

  context 'move, left, move, right, move' do
    let(:commands) { ['PLACE 1,2,NORTH', 'LEFT', 'MOVE', 'RIGHT', 'MOVE', 'REPORT'] }
    let(:command_args) { { robot: robot, commands: commands } }

    it { expect(subject).to eq ['0,3,NORTH'] }
  end

  context 'top right corner' do
    let(:commands) { ['PLACE 4,4,NORTH', 'MOVE', 'MOVE', 'REPORT', 'RIGHT', 'MOVE', 'REPORT'] }
    let(:command_args) { { robot: robot, commands: commands } }

    it { expect(subject).to eq ['4,4,NORTH', '4,4,EAST'] }
  end

  context 'bot left corner' do
    let(:commands) { ['PLACE 0,0,WEST', 'MOVE', 'MOVE', 'REPORT', 'LEFT', 'MOVE', 'REPORT'] }
    let(:command_args) { { robot: robot, commands: commands } }

    it { expect(subject).to eq ['0,0,WEST', '0,0,SOUTH'] }
  end
end
