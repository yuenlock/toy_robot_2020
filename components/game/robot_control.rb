# frozen_string_literal: true

module Game
  class RobotControl
    VALID_COMMANDS = %w[place move left right report].freeze

    def self.call(robot:, commands:)
      new(robot: robot, commands: commands).process
    end

    attr_reader :robot, :commands, :params, :position_class

    def initialize(robot:, commands:, position_class: Game::Position)
      @robot = robot
      @commands = commands
      @params = params
      @position_class = position_class
    end

    def process
      valid_commands.map { |command| robot.send(command[:action], parse_params(command)) }
                    .select { |result| result }
    end

    # private

    def parse_params(command)
      { position: parse_position(command[:params]) } if command[:action] == 'place' && command[:params]
    end

    def valid_commands
      commands.map { |cmd| validate_command(*cmd.split) }.compact
    end

    def validate_command(action, params = nil)
      return unless VALID_COMMANDS.include?(action.downcase!)

      { action: action, params: params }
    end

    def parse_position(pos_string)
      x, y, facing = pos_string.split(',')

      position_class.new(x: x, y: y, facing: facing)
    end
  end
end
