require 'minitest'
require 'minitest/autorun'
require './lib/node'

class NodeTest < Minitest::Test
  def test_check_if_the_class_node_exist
      assert Node.new(1 , "Legends")
  end

  def test_if_score_returns_the_score_of_the_movie
    node = Node.new(1 , "Legends")
    assert_equal 1, node.score
  end

  def test_if_movie_returns_the_movie_title
    node = Node.new(1 , "Legends")
    assert_equal "Legends", node.movie
  end
end
