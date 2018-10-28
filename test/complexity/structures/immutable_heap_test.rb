require "./test/test_helper"
require_relative '../../../lib/complexity/structures/immutable_heap'


class ImmutableHeapTest < Minitest::Test
    def test_pop_immutability
        heap = ImmutableHeap.new(array: [1, 2, 3,4])
        pop, new_heap = heap.pop
        assert_equal pop, 1
        assert_equal heap.peek, 1
        assert_equal new_heap.peek, 2
    end

    def test_push_immutability
        heap = ImmutableHeap.new(array: [27, 35])
        new_heap = heap.push 13
        assert_equal heap.peek, 27
        assert_equal new_heap.peek, 13
    end

    def test_heap
        rnd = Random.new(1337)
        100.times do |_|
            heap = ImmutableHeap.new
            array = Array.new(100) {rnd.rand(100000)}
            array.each{|x| heap = heap.push x}
            array.sort.each do |x|
                value, heap = heap.pop
                assert_equal(x, value)
            end
        end
    end
end