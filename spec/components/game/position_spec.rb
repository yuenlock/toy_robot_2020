require './components/game/position.rb'

RSpec.describe Game::Position do
  let(:x_coord) { 1 }
  let(:y_coord) { 2 }
  let(:facing)  { 3 }
  let(:facing_string) { 'WEST' }

  describe '.new' do
    context 'using integer facing' do
      subject { described_class.new(x: x_coord, y: y_coord, facing: facing) }

      it 'initializes correctly' do
        expect(subject.x).to eq x_coord
        expect(subject.y).to eq y_coord
        expect(subject.facing).to eq facing
      end
    end

    context 'using string facing' do
      subject { described_class.new(x: x_coord, y: y_coord, facing: facing_string) }

      it 'initializes correctly' do
        expect(subject.x).to eq x_coord
        expect(subject.y).to eq y_coord
        expect(subject.facing).to eq facing
      end
    end
  end

  describe '#move' do
    describe 'north' do
      subject { described_class.new(x: x_coord, y: y_coord, facing: 0).move }

      it { expect(subject.x).to eq x_coord }
      it { expect(subject.y).to eq y_coord + 1 }
    end

    describe 'south' do
      subject { described_class.new(x: x_coord, y: y_coord, facing: 2).move }

      it { expect(subject.x).to eq x_coord }
      it { expect(subject.y).to eq y_coord - 1 }
    end

    describe 'east' do
      subject { described_class.new(x: x_coord, y: y_coord, facing: 1).move }

      it { expect(subject.x).to eq x_coord + 1 }
      it { expect(subject.y).to eq y_coord }
    end

    describe 'west' do
      subject { described_class.new(x: x_coord, y: y_coord, facing: 3).move }

      it { expect(subject.x).to eq x_coord - 1 }
      it { expect(subject.y).to eq y_coord }
    end
  end

  describe 'rotate' do
    describe '#left' do
      it 'turns anti-clockwise' do
        position = described_class.new(x: x_coord, y: y_coord, facing: 0).left
        expect(position.facing).to eq 3
      end
    end

    describe '#right' do
      it 'turns clockwise' do
        position = described_class.new(x: x_coord, y: y_coord, facing: 3).right
        expect(position.facing).to eq 0
      end
    end
  end

  describe '#report' do
    it '3,2,EAST' do
      position = described_class.new(x: 3, y: 2, facing: 1)
      expect(position.report).to eq '3,2,EAST'
    end

    it '1,2,WEST' do
      position = described_class.new(x: x_coord, y: y_coord, facing: 3)
      expect(position.report).to eq '1,2,WEST'
    end
  end
end
