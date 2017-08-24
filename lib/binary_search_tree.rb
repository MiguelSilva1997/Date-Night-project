require './lib/node.rb'
require 'pry'
class BinarySearchTree
  attr_accessor :head
  def initialize
    @head = nil
  end

  def insert(score, movie)
    current = Node.new(score, movie)
    if head == nil
      @head = current
      @head.depth
    else
      insert_node(@head, current)
    end
  end

  def insert_node(head, current, count = 0)
    count += 1
    if current.score < head.score
      insert_left_node(head, current, count)
    elsif current.score > head.score
      insert_right_node(head,current, count)
    end
  end

  def insert_left_node(head, current, count)
    if head.left == nil
      head.left = current
      head.left.depth = count
    else
      insert_node(head.left, current, count)
    end
  end

  def insert_right_node(head, current, count)
    if head.right == nil
      head.right = current
      head.right.depth = count
    else
      insert_node(head.right, current, count)
    end
  end

  def include_score?(score, current = @head)
    # binding.pry
    if current.score == score
      true
    elsif score < current.score && current.left != nil
      include_score?(score, current.left)
    elsif score > current.score && current.right != nil
      include_score?(score, current.right)
    else
      false
    end
  end

  def depth_of(score, current = @head)
    if current == nil
      nil
    elsif current.score == score
       current.depth
     elsif score < current.score
       depth_of(score, current.left)
     else
       depth_of(score, current.right)
     end
  end

  def max(current = @head)
    return {current.movie => current.score} if current.right == nil
      max(current.right)
  end

  def min(current = @head)
    return {current.movie => current.score} if current.left == nil
      min(current.left)
  end


  def sort(current = @head, sorted_movies = [])
    sorted_movies << {current.movie => current.score} if current.left.nil?
    sort(current.left, sorted_movies) if current.left != nil
    sorted_movies << {current.movie => current.score}  if !sorted_movies.include?({current.movie => current.score})
    sort(current.right, sorted_movies) if current.right != nil
    sorted_movies
  end

  def load(file)
    movies = File.open("lib/#{file}", 'r')
    movies_array = []
    movies.readlines.map do |line|
      movies_array << line.split(",")
    end
    format_file(movies_array)
  end

  def format_file(movies)
    count = 0
    movies.map do |movie|
      movie_score = movie[0].to_i
    if count == 0
      count +=1
      insert(movie_score, movie[1])
    elsif !include_score?(movie_score)
      count += 1
      insert(movie_score, movie[1])
    end
  end
  count
  end

  def health(depth)
    scores_of_the_movies = score_of_the_node(depth)
    count_of_child_nodes = scores_of_the_movies.map {|n| children_nodes(n)}
    child_nodes_percentage = count_of_child_nodes.map {|n| percentage_of_child_nodes(n)}
    scores_of_the_movies.zip(count_of_child_nodes, child_nodes_percentage)
  end

  def score_of_the_node(depth, current = @head, health = [])
    health << current.score if depth == current.depth
    score_of_the_node(depth, current.left, health) if current.left != nil
    score_of_the_node(depth, current.right, health) if current.right != nil
    health
  end

  def children_nodes(score, current = @head)
    if score == current.score
      amount_of_child_nodes(current)
    elsif score < current.score
      children_nodes(score, current.left)
    else
      children_nodes(score, current.right)
    end
  end

  def amount_of_child_nodes(current, count = [])
    count << {current.movie => current.score} if current.left.nil?
    amount_of_child_nodes(current.left, count) if current.left != nil
    count << {current.movie => current.score}  if !count.include?({current.movie => current.score})
    amount_of_child_nodes(current.right, count) if current.right != nil
    count.length
  end

  def percentage_of_child_nodes(child_nodes)
    percentage = ((child_nodes.to_f / sort.length ) * 100).floor
  end

  def height(current = @head, sorted_depth = [])
    sorted_depth << current.depth if current.left.nil?
    height(current.left, sorted_depth) unless current.left.nil?
    height(current.right, sorted_depth) unless current.right.nil?
    sorted_depth[-1]
  end

  def leaves(current = @head)
    count = 0
    count += 1 if current.left == nil && current.right == nil
    count += leaves(current.left) unless current.left == nil
    count += leaves(current.right) unless current.right == nil
    count
  end
end
