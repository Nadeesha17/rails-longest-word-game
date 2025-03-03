require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample } # Generate random letters
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split

    if !valid_grid?(@word, @letters)
      @message = "The word can't be built from the given letters."
    elsif !valid_english_word?(@word)
      @message = "This is not a valid English word."
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

  def valid_grid?(word, letters)
    word.chars.all? { |char| letters.include?(char) && word.count(char) <= letters.count(char) }
  end

  def valid_english_word?(word)
    url = "https://api.dictionaryapi.dev/api/v2/entries/en/#{word}"
    response = URI.open(url).read
    json_response = JSON.parse(response)

    # Check if the response contains definitions (valid word)
    json_response.is_a?(Array) && json_response.any?
  rescue OpenURI::HTTPError => e
    puts "Error fetching word data: #{e.message}"  # Debugging error message
    false
  end
end
