require 'open-uri'
require 'json'
require 'date'

class GamesController < ApplicationController
  def new
      p session[:score]
      pal = ("a".."z").to_a
      @letters = pal.shuffle
  return @letters = @letters.first(10)
  end

  def score
    @attempt = params[:question]
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    word = open(url).read
    words = JSON.parse(word)
     if grid_validate(@attempt)
     if words['found']
      score = 3 * @attempt.length
      @message = "Congratulations"
      @results = { score: score, message: @message}
    else
      @message = "you lose, the word doesn't exist"
     @results = {  score: 0, message: @message}
    end
    else
    @message = "no esta en las opciones"
    @results = {  score: 0, message: @message}
    end
    if session[:score]
      session[:score] << @results[:score]
    else
      session[:score] = [ @results[:score] ]
    end
  end

   def grid_validate(attempt)
    attempt.chars.all? { |char| !char.delete(char.upcase).nil? }
  end

  def nuevo
      reset_session
    end
end
