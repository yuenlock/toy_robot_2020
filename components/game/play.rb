# frozen_string_literal: true

module Game
  class Play
    def self.call(commands:, robot: Robot.new(grid: Grid.new))
      RobotControl.call(
        commands: commands,
        robot: robot,
        position_class: Position
      )
    end
  end
end
