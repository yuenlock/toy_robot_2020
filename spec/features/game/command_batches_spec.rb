require './components/game.rb'

RSpec.describe 'Commands in Batches' do
  let(:grid) { Game::Grid.new }
  let(:position) { Game::Position.new(x: 1, y: 2, facing: 0) }
  let(:robot) { Game::Robot.new(grid: grid, position: position) }
  let(:position_class) { Game::Position }

  context 'multiple batches' do
    let(:batch_1) { ['PLACE 1,2,NORTH', 'LEFT'] }
    let(:batch_2) { %w[MOVE RIGHT] }
    let(:batch_3) { %w[MOVE REPORT] }
    let(:batched_commands) { [batch_1, batch_2, batch_3] }
    let(:command_args) { { robot: robot, commands: commands } }

    it 'runs the batches' do
      result = batched_commands.map do |commands|
        Game::RobotControl.call(robot: robot, commands: commands, position_class: position_class)
      end

      expect(result).to eq [[], [], ['0,3,NORTH']]
    end
  end
end
