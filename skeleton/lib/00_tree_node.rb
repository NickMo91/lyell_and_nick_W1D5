require "byebug"
class PolyTreeNode

  attr_accessor :value, :parent, :children

    def initialize(value)
      @value = value
      @parent = nil
      @children = []
    end


    def parent=(new_parent)
      # debugger
      # step 1
      # we make sure that we remove self from our old parent's array of children
      # UNLESS we didn't have a parent to begin with 
      unless @parent == nil
        # If we ran the next line, but our parent was == nil, the program would crash
        @parent.children.each_with_index do |child, i| 
          if child == self 
            @parent.children.delete_at(i)
          end
        end
      end

      # step 2
      # we now sever our link pointing to our old parent, and create a link pointing to
      # our new parent

      @parent = new_parent

      # step 3
      # now we put self into our new parent's array of children, UNLESS the new parent
      # was equal to nil (because then the program would crash)
      if @parent != nil && !@parent.children.include?(self)

         @parent.children << self
      end
    end

    def add_child(child)
      # here we make sure we haven't already added this particular child to our children
      # array.  if we haven't already, then we add it
      if !@children.include?(child)
        @children << child
      end
      # here, we make sure that this particular child recognizes us as its one and
      # only parent
      child.parent = self
    end

    def remove_child(child)
      raise "that was not an existing child" if !@children.include?(child)
      child.parent = nil
      @children.each_with_index do |ele,i|
        @children.delete_at(i) if ele == child
      end
    end

    def dfs(target_val)
      # debugger
      return self if @value == target_val

      @children.each do |child|
        result = child.dfs(target_val)
        return result unless result.nil?
      end
      nil
    end

    def bfs(target_val)
      #debugger
      q = [self]
      
      until q.empty?
        ele = q.shift
        if ele.value == target_val
          return ele 
        else
          ele.children.each {|child| q << child}
        end
      end
      nil
    end


    def inspect
      value
    end


end

if __FILE__ == $PROGRAM_NAME
  A = PolyTreeNode.new("A")
  B = PolyTreeNode.new("B")
  C = PolyTreeNode.new("C")
  D = PolyTreeNode.new("D")
  E = PolyTreeNode.new("E")
  F = PolyTreeNode.new("F")

  A.parent = C
  A.parent = B
  A.add_child(D)
  A.add_child(D)
end