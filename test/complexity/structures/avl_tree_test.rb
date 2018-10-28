require "./test/test_helper"
require_relative '../../../lib/complexity/structures/avl_tree'

class AVLTreeTest < Minitest::Test

    def test_should_return_nil_when_empty
        tree = AVLTree.new
        assert_nil (tree.pop)
    end

    def test_should_pop_the_only_element_present
        tree = AVLTree.new
        tree.push 7
        assert_equal(7, tree.pop)
        assert_nil (tree.pop)
    end

    def test_pop_with_right_children
        tree = AVLTree.new
        tree.push 10
        tree.push 5
        tree.push 7
        assert_equal(5, tree.pop)
        assert_equal(7, tree.pop)
        assert_equal(10, tree.pop)
    end

    def test_insert_and_pop_with_rotation
        tree = AVLTree.new
        tree.push 10
        tree.push 5
        tree.push 7
        tree.push 6
        tree.push 3
        tree.push 4
        tree.push 2
        tree.push 8
        tree.push 9
        tree.push 1
        assert_equal(1, tree.pop)
        assert_equal(2, tree.pop)
        assert_equal(3, tree.pop)
        assert_equal(4, tree.pop)
        assert_equal(5, tree.pop)
        assert_equal(6, tree.pop)
        assert_equal(7, tree.pop)
        assert_equal(8, tree.pop)
        assert_equal(9, tree.pop)
        assert_equal(10, tree.pop)
    end

    def test_generated
        rnd = Random.new(1337)
        1000.times do |_|
            tree = AVLTree.new
            numbers = Array.new(100) {rnd.rand(1000000)}
            numbers.each{|x| tree.push x}
            numbers.sort.each{|x| assert_equal(x, tree.pop)}
        end
    end
end