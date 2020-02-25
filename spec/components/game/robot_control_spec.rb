require './components/game/robot_control.rb'

RSpec.describe Game::RobotControl do
  let(:grid) { instance_double 'Game::Grid' }
  let(:robot) { instance_double('Game::Robot') }
  let(:position) { instance_double('Game::Position', x: 1, y: 2, facing: 0) }
  let(:position_class) { class_double('Game::Position') }

  describe '.call' do
    let(:params) { 'some_params' }
    let(:commands) { ['PLACE 1,2,3', 'MOVE'] }
    let(:instance) { instance_double described_class }
    subject { described_class.call(robot: robot, commands: commands) }

    it 'returns the robot' do
      expect(described_class).to(
        receive(:new).with(robot: robot, commands: commands)
                     .and_return(instance)
      )
      expect(instance).to receive(:process).and_return robot

      expect(subject).to eq robot
    end
  end

  describe '#process' do
    let(:command_args) do
      { robot: robot, commands: commands, position_class: position_class }
    end

    subject { described_class.new(**command_args) }

    context 'place and move' do
      let(:commands) { ['PLACE 2,2,2', 'MOVE', 'REPORT'] }

      it 'sends commands' do
        expect(position_class).to receive(:new).with(x: '2', y: '2', facing: '2').and_return position
        expect(robot).to receive(:place).with(position: position)
        expect(robot).to receive(:move)
        expect(robot).to receive(:report).and_return '2,1,SOUTH'

        expect(subject.process).to eq ['2,1,SOUTH']
      end
    end

    context 'place, move, left move, report' do
      let(:commands) { ['PLACE 2,2,2', 'MOVE', 'LEFT', 'MOVE', 'RIGHT', 'REPORT'] }

      it 'sends commands' do
        expect(position_class).to receive(:new).with(x: '2', y: '2', facing: '2').and_return position
        expect(robot).to receive(:place).with(position: position)
        expect(robot).to receive(:move).twice
        expect(robot).to receive(:left)
        expect(robot).to receive(:right)
        expect(robot).to receive(:report).and_return '3,1,SOUTH'

        expect(subject.process).to eq ['3,1,SOUTH']
      end
    end
  end
end
