module Hangman
	class Game
		attr_accessor :mistakes_left, :secret_word, :guessed_letters
		def initialize
			@mistakes_left = 5
			@secret_word = Dictionary.new
			@guessed_letters  = []
		end

		def out_of_turns?
			if mistakes_left == 0
				true
			else
				false
			end
		end


	end
end