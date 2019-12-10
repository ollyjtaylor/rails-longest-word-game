require 'open-uri'
require 'json'

class GamesController < ApplicationController


  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @attempt = params[:attempt]
    @grid = params[:grid].split
    @response = response
    found = english_word?(@attempt)
    in_grid = in_grid?(@attempt, @grid)
    if found && in_grid
      @response = "Well done"
    elsif found && !in_grid
      @response = "not in the grid"
    else
      @response = "not an english word"
    end
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    response = open(url).read
    json = JSON.parse(response)
    return json["found"]
  end


  def in_grid?(attempt, grid)
    upcased = attempt
    upcased.chars.all? { |letter| upcased.count(letter) <= grid.count(letter) }
  end

# def run_game(attempt, grid, start_time, end_time)
#   calculated_score = (attempt.length / (end_time - start_time)).round(2)
#   found = english_word?(attempt)
#   in_grid = in_grid?(attempt, grid)
#   result = { time: (end_time - start_time) }
#   if found && in_grid
#     result[:message] = "Well done"
#     result[:score] = calculated_score
#   elsif found && !in_grid
#     result[:message] = "Not in the grid"
#     result[:score] = 0
#   else
#     result[:message] = "Not an english word"
#     result[:score] = 0
#   end
#   result
# end
end
