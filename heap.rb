class BinaryMinHeap
  def initialize(&prc)
    @store = []
    self.prc = prc || Proc.new{|a, b| a <=> b}
  end

  def count
    @store.length
  end

  def extract
    min = peek

    @store[0] = @store[-1]
    @store.pop()

    self.class.heapify_down(@store, 0, count, &prc)

    min
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)

    self.class.heapify_up(@store, count - 1, count, &prc)

    val
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].reject{|i| i >= len}
  end

  def self.parent_index(child_index)
    raise Exception, "root has no parent" if child_index == 0

    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children = self.child_indices(len, parent_idx)
    prc = Proc.new{|a, b| a <=> b} if prc.nil?

    until children.all?{|child| prc.call(array[parent_idx], array[child]) <= 0}
      smallest_child = prc.call(array[children.first], array[children.last]) <= 0 ? children.first : children.last
      array[parent_idx], array[smallest_child] = array[smallest_child], array[parent_idx]

      parent_idx = smallest_child
      children = self.child_indices(len, parent_idx)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    parent = child_idx == 0 ? nil : self.parent_index(child_idx)
    prc = Proc.new{|a, b| a <=> b} if prc.nil?

    # p prc.call(array[parent], array[child_idx])

    until parent.nil? || prc.call(array[parent], array[child_idx]) <= 0
      array[parent], array[child_idx] = array[child_idx], array[parent]

      child_idx = parent
      parent = child_idx == 0 ? nil : self.parent_index(child_idx)
    end

    array
  end
end
