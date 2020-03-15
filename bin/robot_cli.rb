#!/usr/bin/env ruby

# frozen_string_literal: true

require './components/game.rb'
require './components/io_handlers.rb'

class RobotCLI
  DEFAULT_HANDLERS = {
    input_handler: IOHandlers::FileInput,
    output_handler: IOHandlers::GenericOutput
  }.freeze

  def self.call(input_filename: nil, input: nil, output: nil, output_filename: nil)
    input_handler = input ? Object.const_get(input) : DEFAULT_HANDLERS[:input_handler]
    output_handler = output ? Object.const_get(output) : DEFAULT_HANDLERS[:output_handler]

    commands = input_handler.call(filename: input_filename)

    output_handler.call Game::Play.call(commands: commands), filename: output_filename
  rescue StandardError => e
    output_handler.call [e.message]
  end
end

RobotCLI.call(input_filename: ARGV[0], input: ARGV[1], output: ARGV[2], output_filename: ARGV[3])
