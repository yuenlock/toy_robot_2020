require './components/io_handlers/file_input.rb'

RSpec.describe IOHandlers::FileInput do
  let(:strings) { ['PLACE 0,0,NORTH', 'MOVE', 'REPORT'] }

  describe '.call' do
    subject { described_class.call(filename: filename) }

    context 'valid file' do
      let(:filename) { './spec/data/01_one_step.txt' }
      it 'returns array of strings' do
        expect(subject).to eq strings
      end
    end

    context 'bad filename' do
      let(:filename) { 'bad_file/path' }

      it { expect { subject }.to raise_error(IOHandlers::InvalidFileError) }
    end
  end
end
