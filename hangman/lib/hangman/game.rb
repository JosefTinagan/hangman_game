module Hangman
	class Game
		attr_accessor :mistakes_left, :secret_word, :guessed_letters
		def initialize
			@mistakes_left = 5
			@secret_word = Dictionary.new
			@guessed_letters  = []
		end

		def guess
			while true

				if out_of_turns?

				end
			mistakes_left -= 1
			end
		end

		def game_over
			return :out if out_of_turns?
		end

		def out_of_turns?
			if mistakes_left == 0
				true
			else
				false
			end
		end

		def game_over_message
			return "Out of turns!" if game_over == :out
		end


	end
end