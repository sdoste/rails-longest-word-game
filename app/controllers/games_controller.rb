require 'open-uri' # Allows us to send GET requests and receive the response
require 'json'  # Allows us to parse the reponse into a JSON object/hash

class GamesController < ApplicationController
  def new
    @letters = []
    until @letters.length == 10
      random_letter = ('a'..'z').to_a.sample
      @letters << random_letter
    end
    @letters
  end

  def score
    @letters = params[:letters].split(' ')
    @userinput = params[:userinput].split('')
    word_exists = "<b>Congratulations!</b> #{@userinput.join('').upcase} is a valid English word!".html_safe
    word_doesnt_exist = "Sorry but #{@userinput.join('').upcase} does not seem to be a valid English word..."
    word_cant_be_formed = "Sorry but #{@userinput.join('').upcase} can't be built out of #{@letters.join(', ').upcase}"
    @userinput.each do |letter|
      # Letters not contained
      return word_cant_be_formed unless @letters.include? letter

      @letters.delete_at(@letters.index(letter))
    end
    # Letters are contained in array
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@userinput.join('')}").read
    json = JSON.parse(response)
    # Word exists if found = true, doesnt exist if false
    json['found'] ? word_exists : word_doesnt_exist
  end
  helper_method :score
end
