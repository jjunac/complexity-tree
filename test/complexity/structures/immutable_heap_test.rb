require "./test/test_helper"
require_relative '../../../lib/complexity/structures/immutable_heap'


class ImmutableHeapTest < Minitest::Test
    def test_pop_immutability
        heap = ImmutableHeap.new(array: [1, 2, 3, 4])
        pop, new_heap = heap.pop
        assert_equal 1, pop
        assert_equal 1, heap.peek
        assert_equal 2, new_heap.peek
    end

    def test_push_immutability
        heap = ImmutableHeap.new(array: [27, 35])
        new_heap = heap.push 13
        assert_equal 27, heap.peek
        assert_equal 13, new_heap.peek
    end

    def test_heap
        rnd = Random.new(1337)
        100.times do |_|
            array = Array.new(5) {rnd.rand(100000)}
            heap = ImmutableHeap.new
            array.each {|x| heap = heap.push x}
            array.sort.each do |x|
                value, heap = heap.pop
                assert_equal(value, x)
            end


            heap = ImmutableHeap.new(array: array)
            array.sort.each do |x|
                value, heap = heap.pop
                assert_equal(x, value)
            end
        end
    end
end