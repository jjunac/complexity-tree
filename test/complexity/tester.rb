require_relative '../../lib/complexity/structures/heap'
require_relative '../../lib/complexity/structures/fibonacci_heab'

include Containers

class Array
    def sum
        inject(0.0) {|result, el| result + el}
    end

    def mean
        sum / size
    end
end

class Tester

    def initialize(repeat: 100, arr_len: 10, size_increment: 1000)
        @repeat = repeat
        @arr_len = arr_len
        @size_increment = size_increment
        @array_generator = RandomArrayGenerator.new
        @structs = [Heap, FibonacciHeap]
    end

    def execute_all()
        1..@arr_len. each do |n|
            @repeat.times do
                arr = @array_generator.generate 2 ** n
                adds = @array_generator.generate 2 * @size_increment

                res = {:creation => Hash.new, :insert => Hash.new, :delete => Hash.new}

                @structs.each  do |struct|
                    a = arr.clone
                    crea = Benchmark.measure { s = struct.new a }
                    res[:creation] = {}


                end
            end
        end
    end

end