# frozen_string_literal: true

module IOHandlers
  class FileInput
    VALID_ACTIONS = %w[PLACE MOVE REPORT LEFT RIGHT].freeze

    def self.call(filename:)
      raise InvalidFileError unless valid_file?(filename)

      parse_lines(read_file(filename))
    end

    class << self
      private

      def parse_lines(lines)
        lines.select { |cmd| valid_command?(cmd.split[0]) }
      end

      def read_file(filename)
        File.read(filename).split("\n")
      end

      def valid_command?(action)
        VALID_ACTIONS.include? action
      end

      def valid_file?(filename)
        File.exist? filename
      end
    end
  end

  class InvalidFileError < StandardError
    def message
      'Error: File could not be found. Please provide a valid file.'
    end
  end
end
