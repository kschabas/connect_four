# frozen_string_literal: true

require './lib/connect_four'

describe ConnectFour do
  describe '#play_game' do
    subject(:test_game) { described_class.new }
    let(:test_board) { double('Board') }

    before do
      allow(test_board).to receive(:new).and_return([])
    end

    context 'loops until game is won' do
      it 'will exit correctly if won after 1 move' do
        allow(test_game).to receive(:winner?).and_return(true)
        expect(test_game).to receive(:winner?).once
        test_game.play_game
      end

      it 'will exit correctly if won after 3 moves' do
        allow(test_game).to receive(:winner?).and_return(true, false, false)
        expect(test_game).to receive(:winner?).thrice
        test_game.play_game
      end
    end
  end
end
