# frozen_string_literal: true

## Game Controller
class GamesController < ApplicationController
  def index
    redirect_to new_path
  end

  def new
    session[:score] = 0 unless session[:score]
    @letters = (1..10).map do
      rand(65..90).chr
    end
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(" ")
    return @state = :not_in_grid unless word_in_letters?(@word, @letters)

    check = check_word(@word)
    if check["found"]
      @score = check["length"]
      session[:score] += @score
      @new_score = session[:score]
      @state = :gg
    else
      @state = :mispelled
    end
  end

  private

  def word_in_letters?(word, letters)
    character_set = letters.clone
    word.upcase.chars.each do |character|
      return false unless character_set.include?(character)

      character_set.delete_at(character_set.index(character))
    end

    true
  end

  def check_word(word)
    url = 'https://wagon-dictionary.herokuapp.com/' + word.downcase

    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end
end
