require_relative "00_tree_node.rb"

class KnightPathFinder

  attr_accessor :pos, :considered, :root

  def self.valid_moves(pos)

    valids = []
    x, y = pos

    if x > 7 || x < 0 || y > 7 || y < 0
      raise "invalid position"
    end
    up = x - 2
    left = y - 1
   #debugger
    while up <= x + 2
      left = y -1
      while left <= y + 1
        if left >= 0 && left < 8
          if up >= 0 && up < 8
            valids << [up, left]
          end
        end
        left += 2
      end
      up += 4
    end

    up = y -2
    left = x - 1

    while up <= y + 2
      left = x - 1
      while left <= x + 1
        if left >= 0 && left < 8
          if up >= 0 && up < 8
            valids << [left, up]
          end
        end
        left += 2
      end
      up += 4
    end
    valids
  end









  def initialize(pos)
    @pos = pos
    @root = PolyTreeNode.new(pos)
    @considered = [pos]
    build_move_tree(@root)
  end

  def build_move_tree(node)
    # debugger
    q = [node]
    until q.empty?
      cur_node = q.shift
      moves = new_move_positions(cur_node.value)
      moves.each do |move|
        child = PolyTreeNode.new(move)
        cur_node.children << child
      end
      cur_node.children.each { |child| q << child }
    end
    node 
  end

  def new_move_positions(pos)
    # debugger
    moves = KnightPathFinder.valid_moves(pos)
    new_moves = []
    new_moves = moves.select {|move| !@considered.include?(move)}
    @considered.concat(new_moves)
    new_moves
  end

  def find_path(pos)
    self.root.dfs(pos)
  end
end


if __FILE__ == $PROGRAM_NAME
  g = KnightPathFinder.new([0,0])
end