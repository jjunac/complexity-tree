require_relative '../../lib/complexity/structures/heap'
require_relative '../../lib/complexity/structures/immutable_heap'
require_relative '../../lib/complexity/structures/fibonacci_heab'
require_relative 'array_generator'
require 'benchmark'

class Array
    def sum
        inject(0.0) {|result, el| result + el}
    end

    def mean
        sum / size
    end
end

class Tester

    def initialize(repeat: 100, arr_len: 10, size_increment: 1000, structs: [Heap, FibonacciHeap, ImmutableHeap])
        @repeat = repeat
        @arr_len = arr_len
        @size_increment = size_increment
        @array_generator = RandomArrayGenerator.new
        @structs = structs
    end

    def execute_all()
        sizes = []
        results = Hash.new
        @structs.each do |struct_class|
            results[struct_class.name + "_insertion"] = Array.new(@arr_len, 0)
            results[struct_class.name + "_deletion"] = Array.new(@arr_len, 0)
            results[struct_class.name + "_creation"] = Array.new(@arr_len, 0)
        end
        (1..@arr_len).each do |n|
            size = 2 ** n
            sizes << size
            @repeat.times do
                arr = @array_generator.generate size
                to_insert = @array_generator.generate size
                @structs.each do |struct_class|
                    struct_res = {:creation => [], :insert => [], :delete => []}
                    copy = arr.clone
                    struct = nil
                    creation_time = Benchmark.measure {struct = struct_class.new array: copy}.real

                    double_insertion_time = []
                    deletion_time = []
                    (0...to_insert.length - 1).step(2).each do |i|
                        double_insertion_time << Benchmark.measure {
                            struct = struct.push(to_insert[i])
                            struct = struct.push(to_insert[i + 1])
                        }.real
                        deletion_time << Benchmark.measure {_, struct = struct.pop}.real
                    end

                    results[struct_class.name + "_insertion"][n - 1] += double_insertion_time.sum / 2
                    results[struct_class.name + "_deletion"][n - 1] += deletion_time.sum
                    results[struct_class.name + "_creation"][n - 1] += creation_time
                end
            end
            results.each {|_, res|
                res[n - 1] = res[n - 1] / @repeat
            }
        end
        [results, sizes]
    end

end