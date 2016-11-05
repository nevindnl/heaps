require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new()
    length = self.length
    length.times do |el|
      heap.push(self.pop)
    end
    length.times do
      self.push(heap.extract)
    end
  end
end
