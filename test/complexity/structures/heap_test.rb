require "./test/test_helper"
require_relative '../../../lib/complexity/structures/heap'


class HeapTest < Minitest::Test
    def test_heap
        rnd = Random.new(1337)
        100.times do |_|
            array = Array.new(100) {rnd.rand(100000)}

            heap = Heap.new
            array.each {|x| heap.push x}
            array.sort.each do |x|
                value, _ = heap.pop
                assert_equal(x, value)
            end

            heap = Heap.new array: array
            array.sort.each do |x|
                value, _ = heap.pop
                assert_equal(x, value)
            end


        end
    end
end