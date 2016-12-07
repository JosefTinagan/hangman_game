require 'spec_helper'

module Hangman
   describe Dictionary do
      context "#initialize" do
         it "initializes with no error" do
         	expect { Dictionary.new("lol")}.to_not raise_error
         end

         it "initializes the word with the passed word" do
         	d = Dictionary.new("fergalic")
         	expect(d.word).to eq "fergalic"
         end

         it "initializes with a random word by default" do
         	d = Dictionary.new
         	arr = [d.word]
         	expect(arr).to have_at_least(1).items
         end
      end	

   end
end