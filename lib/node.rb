class Node
  attr_accessor :score, :movie, :right, :left, :depth
  def initialize(score , movie)
    @score = score
    @movie = movie
    @right = right
    @left = left
    @depth = 0
  end
end
