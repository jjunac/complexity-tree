class RandomArrayGenerator
    def initialize(number_max: 10000000000000)
        @number_max = number_max
    end

    def generate(size)
        (0...size).map {rand(@number_max)}
    end
end

class SeededRandomArrayGenerator

    def initialize(seed, number_max: 10000000000000)
        @rand = Random.new(seed)
        @number_max = number_max
    end

    def generate(size)
        (0...size).map do
            rand(@number_max)
        end
    end
end

class ReverseSortedArrayGenerator

    def generate(size)
        (size...0)
    end
end

class SortedArrayGenerator

    def generate(size)
        (0...size)
    end
end