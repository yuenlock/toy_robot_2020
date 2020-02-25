require './components/game.rb'

RSpec.describe 'Place' do
  let(:grid) {  Game::Grid.new }
  let(:robot) { Game::Robot.new(grid: grid) }
  let(:init_position) { Game::Position.new(x: 1, y: 1, facing: 0) }

  it 'place and report' do
    robot.place(position: init_position)
    expect(robot.report).to eq '1,1,NORTH'
  end

  it 'place, move and report' do
    robot.place(position: init_position)
    robot.move
    expect(robot.report).to eq '1,2,NORTH'
  end

  it 'place, left, left, right, report' do
    robot.place(position: init_position)
    robot.right
    robot.right
    robot.left
    expect(robot.report).to eq '1,1,EAST'
  end

  it 'place, move, left, move, left, move, report' do
    robot.place(position: init_position)
    robot.move # 1,2,0
    robot.left # 1,2,3
    robot.move # 0,2,3
    expect(robot.report).to eq '0,2,WEST'
  end

  it 'place, right, move, move, right, move, right, report' do
    robot.place(position: init_position)
    robot.right # 1,1,1
    robot.move  # 2,1,1
    robot.move  # 3,1,1
    robot.right # 3,1,2
    robot.move  # 3,0,2
    robot.right # 3,0,3
    expect(robot.report).to eq '3,0,WEST'
  end
end
