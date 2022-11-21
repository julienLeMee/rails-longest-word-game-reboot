require 'open-uri'

class GamesController < ApplicationController
  VOYELLES = ['A','E','I','O','U','Y']

  # def new
  #   @letters += Array.new(5) { VOYELLES.sample }
  #   @letters += Array.new(5) { (('A'..'Z').to_a - VOYELLES).sample }
  #   @letters.shuffle!
  # end

  def new
    @letters = []
    5.times do
      @letters << ('A'..'Z').to_a.sample
      @letters << VOYELLES.sample
    end
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || '').upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  # def score_params
  #   params.require(:word).permit(:letters)
  # end

  def included?(word, letters)
    # word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json[:found]
  end
end
