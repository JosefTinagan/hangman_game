module Hangman
	class Game
		attr_accessor :mistakes_left, :secret_word, :guessed_letters, :current_word
		def initialize(word_to_use = Dictionary.new.word)
			@mistakes_left = 5
			@secret_word = word_to_use.split("")
			@guessed_letters  = []
		end

		def start
			turns = 5
			create_board
			while true
				letter_picked = ask_input

				if correct_letter?(letter_picked)
					update_current_word(letter_picked)
					guessed_letters.push(letter_picked)
				else
					puts "Wrong letter"
					turns -= 1
					@mistakes_left = turns
				end

				if check_victory
					puts game_over_message
					display_current_word
					return
				end
				
			end
		end

		def correct_letter?(letter)
			return true if secret_word.include?(letter)
			false
		end

		def ask_input
			puts "Mistakes left till out of turns: #{mistakes_left}"
			puts "Enter a letter"
			input = gets.chomp

			if input_valid?(input)
				input
			else
				puts "Invalid input, try again"
				ask_input
			end
		end

		def input_valid?(input)
			return true if input.length == 1 && !letter_already_picked?(input)
			false
		end

		def letter_already_picked?(input)
			return true if guessed_letters.include?(input)
			false
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
			return :out if out_of_turns?
			false
		end

		def victory?
			p current_word
			puts
			p secret_word
			return true if current_word.join == secret_word.join
			false
		end

		def out_of_turns?
			if mistakes_left == 0
				true
			else
				false
			end
		end

		def game_over_message
			#return "Out of turns!" if game_over == :out
			return "You won!" if check_victory == :win
			return "Out of turns" if check_victory == :out
		end

	end
end

