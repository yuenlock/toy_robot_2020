#!/usr/bin/env ruby

# frozen_string_literal: true

require './components/game.rb'
require './components/io_handlers.rb'

class RobotCLI
  DEFAULT_HANDLERS = {
    output_handler: IOHandlers::ScreenOutput,
    input_handler: IOHandlers::FileInput
  }.freeze

  def self.call(filename:, input_handler: nil, output_handler: nil)
    input_handler = input_handler ? Object.const_get(input_handler) : DEFAULT_HANDLERS[:input_handler]
    output_handler  = DEFAULT_HANDLERS[:output_handler]
    commands = input_handler.call(filename: filename)

    output_handler.call Game::Play.call(commands: commands)
  rescue StandardError => e
    output_handler.call [e.message]
  end
end

RobotCLI.call(filename: ARGV[0], input_handler: ARGV[1], output_handler: ARGV[2])
