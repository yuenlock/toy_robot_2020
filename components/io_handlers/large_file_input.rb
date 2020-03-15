# frozen_string_literal: true

module IOHandlers
  class LargeFileInput
    VALID_ACTIONS = %w[PLACE MOVE REPORT LEFT RIGHT].freeze
    MAX_LINES_PER_BATCH = 10

    def self.call(filename:, &block)
      raise InvalidFileError unless valid_file?(filename)

      new(file: File.new(filename)).process(&block)
    end

    attr_reader :file
    def initialize(file:)
      @file = file
    end

    def process
      yield batch_of_commands until end_of_file?
    end

    def batch_of_commands
      lines = []
      until end_of_file? || lines.count == MAX_LINES_PER_BATCH
        line = file.readline
        lines << line if validate(line)
      end
      lines
    end

    def validate(line)
      line if VALID_ACTIONS.include? line.split[0]
    end

    def end_of_file?
      file.eof?
    end

    def self.valid_file?(filename)
      File.exist? filename
    end
  end
end
