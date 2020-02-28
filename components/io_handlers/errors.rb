# frozen_string_literal: true

module IOHandlers
  class InvalidFileError < StandardError
    def message
      'Error: File could not be found. Please provide a valid file.'
    end
  end
end
