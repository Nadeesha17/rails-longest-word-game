class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample } # Generates random letters
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    if !valid_grid?(@word.upcase, @letters)
      @message = "The word can't be built from the given letters."
    elsif !valid_english_word?(@word)
      @message = " This is not a valid English word."
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

  def valid_grid?(word, letters)
    word.chars.all? { |char| letters.include?(char) && letters.count(char) >= word.count(char) }
  end

  def valid_english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    JSON.parse(response)["found"]
  rescue
    false
  end
end
