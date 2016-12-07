module Hangman
	class Dictionary
		attr_reader :word
		def initialize(word = get_words)
			@word = word
		end

		def get_words
			file_path = File.join(File.dirname(__FILE__),"5desk.txt")
		
			puts file_path
			array_of_words = File.readlines(file_path)
			
			while true
				current_word = get_random_word(array_of_words).strip
				
				if current_word.length > 5 && current_word.length < 12
					return current_word
					break
				else
					current_word = get_random_word(array_of_words)
				end
			end
		end

		def random_number(num)
			rand(num)
		end

		def get_random_word(arr)
			num = random_number(arr.length - 1)
			return arr[num]

		end
	end
end 
=begin
include Hangman
d = Dictionary.new
x = d.word
puts x.length
puts x
=end