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

		context "#game_over_message" do
			it "returns 'Out of turns!' if #game_over returns :out" do
				g = Game.new
				allow(g).to receive(:game_over).and_return(:out)
				expect(g.game_over_message).to eq "Out of turns!"
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
	end
end