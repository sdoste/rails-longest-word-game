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
    @userinput = params[:userinput].split(' ')
    @userinput.each do |letter|
      if @userinput.include? letter
        @answer = "well now i have to check if it exists or not"
      else
        @answer = "Sorry but #{letter} can't be built out of #{@letters}"
      end
    end
  end
end
