module Hangman
	class Game
		attr_accessor :mistakes_left, :secret_word, :guessed_letters, :current_word
		def initialize(word_to_use = Dictionary.new.word)
			@mistakes_left = 5
			@secret_word = word_to_use.split("")
			@guessed_letters  = []
		end

		def start

			while true

				if out_of_turns?
					game_over_message
				end
			mistakes_left -= 1
			end
		end

		def ask_input
			puts "Enter a letter"
			input = gets.chomp
		end

		def update_current_word(letter)
			temp = []
			#secret_word = secret_word.split("")
			secret_word.each_with_index do |x, indx|
				if x == letter
					temp.push(indx)
				end
			end

			temp.each do |x|
				current_word.delete_at(x)
				current_word.insert(x,letter)
			end

			current_word
		end

		def create_board
			@current_word = Array.new(secret_word.length, "_")
		end

		def display_current_word
			current_word.each do |x|
				print "#{x} "
			end
		end

		def check_victory
			return :win if victory?
			return :out if out_of_turns?s
		end

		def victory?
			p current_word
			puts
			p secret_word
			return true if current_word.join == secret_word.join
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