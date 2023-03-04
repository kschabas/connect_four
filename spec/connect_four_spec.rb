# frozen_string_literal: true

require './lib/connect_four'

describe ConnectFour do
  describe '#play_game' do
    subject(:test_game) { described_class.new(test_board) }
    let(:test_board) { double('Board') }

    before do
      allow(test_game).to receive(:user_input)
      allow(test_game).to receive(:make_move)
      allow(test_game).to receive(:change_turn)
      allow(test_game).to receive(:print_board)
    end

    context 'game is won immediately' do
      before do
        allow(test_game).to receive(:winner?).and_return(true)
      end
      it 'will exit correctly if won after 1 move' do
        expect(test_game).to receive(:winner?).once
        test_game.play_game
      end
      it 'will call not call #user_input' do
        expect(test_game).to_not receive(:user_input)
        test_game.play_game
      end
      it 'will not call #make_move' do
        expect(test_game).to_not receive(:make_move)
        test_game.play_game
      end
      it 'will not call #change_turn' do
        expect(test_game).to_not receive(:change_turn)
        test_game.play_game
      end
      it 'will not call print_board' do
        expect(test_game).to_not receive(:print_board)
        test_game.play_game
      end
      it 'will call end_game once' do
        expect(test_game).to receive(:end_of_game).once
        test_game.play_game
      end
    end

    context 'game takes 4 turns to win' do
      before do
        allow(test_game).to receive(:winner?).and_return(false, false, true)
        allow(test_game).to receive(:user_input).and_return([2, 3])
      end
      it 'will exit correctly if won after 3 moves' do
        expect(test_game).to receive(:winner?).thrice
        test_game.play_game
      end
      it 'will call #user_input twice' do
        expect(test_game).to receive(:user_input).twice
        test_game.play_game
      end
      it 'will call #make_move twice' do
        expect(test_game).to receive(:make_move).with([2, 3]).twice
        test_game.play_game
      end
      it 'will call #change_turn twice' do
        expect(test_game).to receive(:change_turn).twice
        test_game.play_game
      end
      it 'will call print_board twice' do
        expect(test_game).to receive(:print_board).twice
        test_game.play_game
      end
      it 'will call end_game once' do
        expect(test_game).to receive(:end_of_game).once
        test_game.play_game
      end
    end
  end

  describe '#winner?' do
    subject(:test_game) { described_class.new(test_board) }
    let(:test_board) { double('Board') }

    context 'game has no winner' do
      before do
        allow(test_game).to receive(:four_in_a_row?).and_return(false)
      end

      it '#calls four_in_a_row? the right number of times' do
        expect(test_game).to receive(:four_in_a_row?).exactly(described_class::BOARD_HEIGHT * described_class::BOARD_WIDTH).times
        test_game.winner?
      end

      it 'receives a given coordinate once' do
        expect(test_game).to receive(:four_in_a_row?).with(3, 3).once
        test_game.winner?
      end

      it 'return the false value' do
        result = test_game.winner?
        expect(result).to be false
      end
    end
    context 'game has a winner' do
      before do
        allow(test_game).to receive(:four_in_a_row?).and_return(false)
        allow(test_game).to receive(:four_in_a_row?).with(4, 3).and_return(true)
      end

      it 'returns a winner' do
        expect(test_game).to be_winner
      end
    end
  end
  describe 'test #four_in_a_row?' do
    subject(:test_game) { described_class.new(test_board) }
    let(:test_board) { double('Board') }

    before do
      allow(test_game).to receive(:valid_space?).with(3, 3).and_return(true)
      allow(test_game).to receive(:valid_space?).with(10, 10).and_return(false)
    end

    it 'returns false if illegal space give' do
      result = test_game.four_in_a_row?(10, 10)
      expect(result).to be false
    end

    it 'returns false if no piece at square' do
      allow(test_board).to receive(:coord).with(3, 3).and_return(nil)
      result = test_game.four_in_a_row?(3, 3)
      expect(result).to be false
    end

    context 'token present at space' do
      x = 3
      y = 3
      token = 'B'
      before do
        allow(test_board).to receive(:coord).with(x, y).and_return(token)
        allow(test_game).to receive(:horizontal_row?).and_return(false)
        allow(test_game).to receive(:vertical_row?).and_return(false)
        allow(test_game).to receive(:positive_slope_diag_row?).and_return(false)
        allow(test_game).to receive(:negative_slope_diag_row?).and_return(false)
      end
      it 'calls horizontal_row?' do
        expect(test_game).to receive(:horizontal_row?).once
        test_game.four_in_a_row?(x, y)
      end
      it 'calls vertical_row?' do
        expect(test_game).to receive(:vertical_row?).once
        test_game.four_in_a_row?(x, y)
      end
      it 'calls positive_slope_diag' do
        expect(test_game).to receive(:positive_slope_diag_row?).once
        test_game.four_in_a_row?(x, y)
      end
      it 'calls negative_slope_diag' do
        expect(test_game).to receive(:negative_slope_diag_row?).once
        test_game.four_in_a_row?(x, y)
      end
      it 'returns false if no four in a row' do
        result = test_game.four_in_a_row?(x, y)
        expect(result).to be false
      end
      it 'returns true if  horizontal_row returns true' do
        allow(test_game).to receive(:horizontal_row?).with(x, y, token).and_return(true)
        result = test_game.four_in_a_row?(x, y)
        expect(result).to be true
      end
      it 'returns true if negative_slope_diag returns true' do
        allow(test_game).to receive(:negative_slope_diag_row?).with(x, y, token).and_return(true)
        result = test_game.four_in_a_row?(x, y)
        expect(result).to be true
      end
    end
  end
end
