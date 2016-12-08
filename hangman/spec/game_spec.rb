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
				expect(g.secret_word.word).to have_at_least(1).thing
			end
		end

		context "#guess" do

		end

		context "#game_over" do
			it "returns :out if out_of_turns returns true" do
				g = Game.new
				allow(g).to receive(:out_of_turns?).and_return(true)
				expect(g.game_over).to eq :out
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