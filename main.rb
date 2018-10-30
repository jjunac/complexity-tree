require_relative 'lib/complexity/structures/heap'
require_relative 'lib/complexity/structures/immutable_heap'
require_relative 'lib/complexity/structures/fibonacci_heab'
require_relative 'lib/complexity/structures/avl_tree'
require_relative 'lib/complexity/structures/immutable_avl_tree'
require_relative 'lib/complexity/structures/ruby_red_black'
require_relative 'lib/complexity/structures/native_red_black'
require_relative 'test/complexity/tester'
require_relative 'test/complexity/csv_exporter'


tester = Tester.new(arr_len: 22, structs: [Heap, ImmutableHeap, AVLTree, ImmutableAVLTree, RubyRedBlack, NativeRedBlack])
csv_exporter = CSVExporter.new

insertion, sizes = tester.execute_all
csv_exporter.export_map("test.csv", sizes, insertion)