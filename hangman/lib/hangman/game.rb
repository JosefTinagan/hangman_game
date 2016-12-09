module Hangman
	class Game
		attr_accessor :mistakes_left, :secret_word, :guessed_letters, :current_word, :loaded_game
		def initialize(word_to_use = Dictionary.new.word)
			@mistakes_left = 5
			@secret_word = word_to_use.split("")
			@guessed_letters  = []
			@loaded_game = false
		end

		def start
			ask_to_load

			if loaded_game
				@loaded_game = false
				turns = @mistakes_left

			else
				turns = 5
				create_board
			end

			while true
				puts "Now playing..."
				puts "The current word is: #{current_word}"
				puts "Letters already picked: #{guessed_letters}"

				letter_picked = ask_input

				if correct_letter?(letter_picked)
					update_current_word(letter_picked)
					guessed_letters.push(letter_picked)
					puts "Correct letter!"
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

				ask_to_save	
			end
		end

		def correct_letter?(letter)
			return true if @secret_word.include?(letter)
			false
		end

		def ask_to_save
			puts "Do you want to save? (Y / N)"
			input = gets.chomp.upcase!

			if input == "Y"
				save_game
			elsif input == "N"
				false
			else
				puts "Invalid input, try again"
				ask_to_save
			end
		end

		def save_game
			p mistakes_left
			p guessed_letters
			p secret_word
			p current_word
			header = ["mistakes_left","guessed_letters","secret_word","current_word"]
			values = [mistakes_left,guessed_letters.join,secret_word.join,current_word.join]
			p header
			p values

			File.open("saved_game.csv","w") do |x|
				x.puts header.join(",")
				x.puts values.join(",")
			end
		end

		def ask_to_load
			puts "Would you like to load a game? (Y/N)"
			input = gets.chomp.upcase!

			if input == "Y"
				load_game
			elsif input == "N"
				false
			else
				"Invalid input... Try again"
				ask_to_load
			end
		end

		def load_game
			@loaded_game = true
			temp_array = []

			CSV.open("saved_game.csv").each do |x|
				temp_array.push(x)
			end
			p temp_array

			@mistakes_left = temp_array[1][0].to_i
			@guessed_letters = temp_array[1][1].split("")
			@secret_word = temp_array[1][2].split("")
			@current_word = temp_array[1][3].split("")

			p mistakes_left
			p guessed_letters
			p secret_word
			p current_word
		end

		def ask_input
			puts "Mistakes left till out of turns: #{mistakes_left}"
			puts "Enter a letter"
			input = gets.chomp

			if letter_already_picked?(input)
				puts "You already picked that letter"
				ask_input
			elsif input_valid?(input)
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

			#current_word
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
			#p current_word
			#puts
			#p secret_word
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

