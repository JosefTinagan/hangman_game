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