require 'spec_helper'

module Hangman
	describe Game do
		context "#initialize" do
			it "initializes mistakes_left by 5" do
				g = Game.new
				expect(g.mistakes_left).to eq 5
			end

			it "initializes with a secret word" do
				g = Game.new
				expect(g.secret_word).to have_at_least(1).thing
			end
		end

		context "#start" do

		end

		context "#correct_letter?" do
			it "return true if the letter is included in the secret word" do
				g = Game.new
				g.secret_word.push("b")
				g.secret_word.push("o")
				expect(g.correct_letter?("b")).to be true
			end
		end

		context "#ask_to_save" do
			it "returns false if the input is N" do
				g = Game.new

			end
		end

		context "#save_game" do
			it "saves variables" do
				g = Game.new
				g.guessed_letters.push("b")
				g.guessed_letters.push("y")
				g.create_board
				g.save_game
			end
		end

		context "#load_game" do
			it "loads game" do
				g = Game.new
				g.load_game
			end
		end

		context "#ask_input" do
			it "returns input if the letter is valid" do
				g = Game.new

			end
		end

		context "#input_valid?" do
			it "returns true if input has the length of one and not already picked" do
				g = Game.new
				expect(g.input_valid?('b')).to be true
			end
		end

		context "#letter_already_picked?" do
			it "return true if input is included already in the guessed_letter array" do
				g = Game.new
				g.guessed_letters.push("x")
				expect(g.letter_already_picked?("x")).to be true
			end
		end

		context "#update_current_word" do
			it "returns a new array that includes a letter passed" do
				g = Game.new("flagger")
				g.create_board
				#expect(g.update_current_word("g")).to eq ["_"]
				g.update_current_word("g")
				expect(g.current_word.join).to eq "___gg__"
				g.update_current_word("r")
				expect(g.current_word.join).to eq "___gg_r"
			end
		end

		context "#create_board" do
			it "returns an array of underscores" do
				g = Game.new
				arr = Array.new(g.secret_word.length, "_")
				expect(g.create_board).to eq arr
			end
		end

		context "#display_current_word" do
			it "returns a bunch of underscores by default" do
				g = Game.new
				g.create_board
				arr = Array.new(g.secret_word.length,"_")
				expect(g.display_current_word).to eq arr
			end
		end

		context "#check_victory" do
			it "returns :out if out_of_turns? returns true" do
				g = Game.new
				g.current_word = ["a","b"]
				allow(g).to receive(:out_of_turns?).and_return(true)
				expect(g.check_victory).to eq :out
			end

			it "returns :win if victory? returns true" do
				g = Game.new
				#g.current_word = ["a","b"]
				allow(g).to receive(:victory?).and_return(true)
				expect(g.check_victory).to eq :win
			end
		end

		context "#victory?" do
			it "returns true if current.word is equal to secret.word" do
				g = Game.new("beaner")
				g.current_word = ["b","e","a","n","e","r"]
				expect(g.victory?).to be true
			end
		end

		context "#out_of_turns?" do
			it "returns false if mistakes_left is not zero" do
				g = Game.new
				expect(g.out_of_turns?).to be false
			end

			it "returns true if mistakes_left is zero" do
				g = Game.new
				g.mistakes_left = 0
				expect(g.out_of_turns?).to be true
			end
		end

		context "#game_over_message" do
			it "returns 'Out of turns!' if #game_over returns :out" do
				g = Game.new
				allow(g).to receive(:check_victory).and_return(:out)
				expect(g.game_over_message).to eq "Out of turns"
			end

			it "returns 'You won' if #game_over returns :win" do
				g = Game.new
				allow(g).to receive(:check_victory).and_return(:win)
				expect(g.game_over_message).to eq "You won!"
			end
		end

	end
end