require "./test/test_helper"
require_relative '../../../lib/complexity/structures/immutable_avl_tree'

class ImmutableAVLTreeTest < Minitest::Test

    def test_should_return_nil_when_empty
        tree = ImmutableAVLTree.new
        value, new_root = tree.pop
        assert_nil (value)
        value2, new_root2 = new_root.pop
        assert_nil (value2)
    end

    def test_push_doesnt_mutate_tree
        tree = ImmutableAVLTree.new
        tree.push 7
        value, new_root = tree.pop
        assert_nil(value)
    end

    def test_should_pop_the_only_element_present
        tree = ImmutableAVLTree.new
        tree = tree.push 7
        value, tree = tree.pop
        assert_equal(7, value)
        value, tree = tree.pop
        assert_nil (value)
    end

    def test_pop_with_right_children
        tree = ImmutableAVLTree.new
        tree = tree.push 10
        tree = tree.push 5
        tree = tree.push 7
        value, tree = tree.pop
        assert_equal(5, value)
        value, tree = tree.pop
        assert_equal(7, value)
        value, tree = tree.pop
        assert_equal(10, value)
        value, tree = tree.pop
        assert_nil(value)
    end

    def test_insert_and_pop_with_rotation
        tree = ImmutableAVLTree.new
        tree = tree.push 10
        tree = tree.push 5
        tree = tree.push 7
        tree = tree.push 6
        tree = tree.push 3
        tree = tree.push 4
        tree = tree.push 2
        tree = tree.push 8
        tree = tree.push 9
        tree = tree.push 1

        value, tree = tree.pop
        assert_equal(1, value)
        value, tree = tree.pop
        assert_equal(2, value)
        value, tree = tree.pop
        assert_equal(3, value)
        value, tree = tree.pop
        assert_equal(4, value)
        value, tree = tree.pop
        assert_equal(5, value)
        value, tree = tree.pop
        assert_equal(6, value)
        value, tree = tree.pop
        assert_equal(7, value)
        value, tree = tree.pop
        assert_equal(8, value)
        value, tree = tree.pop
        assert_equal(9, value)
        value, tree = tree.pop
        assert_equal(10, value)
        value, tree = tree.pop
        assert_nil(value)
    end

    def test_shouldnt_mutate_old_tree
        tree = ImmutableAVLTree.new
        tree = tree.push 10
        tree = tree.push 5
        tree = tree.push 7
        tree = tree.push 6
        tree2 = tree.push 3
        tree2 = tree2.push 4
        tree2 = tree2.push 2
        tree2 = tree2.push 8
        tree2 = tree2.push 9
        tree2 = tree2.push 1

        value, tree2 = tree2.pop
        assert_equal(1, value)
        value, tree2 = tree2.pop
        assert_equal(2, value)
        value, tree2 = tree2.pop
        assert_equal(3, value)
        value, tree2 = tree2.pop
        assert_equal(4, value)
        value, tree2 = tree2.pop
        assert_equal(5, value)
        value, tree2 = tree2.pop
        assert_equal(6, value)
        value, tree2 = tree2.pop
        assert_equal(7, value)
        value, tree2 = tree2.pop
        assert_equal(8, value)
        value, tree2 = tree2.pop
        assert_equal(9, value)
        value, tree2 = tree2.pop
        assert_equal(10, value)
        value, tree2 = tree2.pop
        assert_nil(value)

        value, tree = tree.pop
        assert_equal(5, value)
        value, tree = tree.pop
        assert_equal(6, value)
        value, tree = tree.pop
        assert_equal(7, value)
        value, tree = tree.pop
        assert_equal(10, value)
        value, tree = tree.pop
        assert_nil(value)

    end

    def test_generated
        rnd = Random.new(1337)
        1000.times do |_|
            tree = ImmutableAVLTree.new
            numbers = Array.new(100) {rnd.rand(1000000)}
            numbers.each{|x| tree = tree.push x}
            numbers.sort.each{|x| value, tree = tree.pop; assert_equal(x, value)}
        end
    end
end