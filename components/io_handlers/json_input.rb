# frozen_string_literal: true

require 'json'

module IOHandlers
  class JsonInput
    VALID_ACTIONS = %w[PLACE MOVE REPORT LEFT RIGHT].freeze

    def self.call(filename:)
      raise InvalidFileError unless valid_file?(filename)

      parse_json(read_file(filename))
    end

    class << self
      private

      def parse_json(json_content)
        lines = JSON.parse(json_content).fetch('commands', [])
        lines.select { |cmd| valid_command?(cmd.split[0]) }
      end

      def read_file(filename)
        File.read(filename)
      end

      def valid_command?(action)
        VALID_ACTIONS.include? action
      end

      def valid_file?(filename)
        File.exist? filename
      end
    end
  end
end
