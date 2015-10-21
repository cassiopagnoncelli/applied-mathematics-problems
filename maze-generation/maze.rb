class Maze
  # Initizialization.
  #
  # @maze: grid
  # @rows, @cols: maze dimensions
  # @start_point, @end_point: start ('s') and end ('e') positions
  #
  def initialize(path)
    file = File.new(path, 'r')

    @maze = []
    @rows = 0
    while (line = file.gets)
      row = line.split('')
      row.pop
      @maze.push(row)
      @rows += 1
    end
    @cols = @maze[0].length

    file.close
    validates_maze

    @correct_path = Array.new(@rows) { Array.new(@cols) { ' ' } }
  end

  # Map validation.
  def validates_maze
    # check dimensions
    raise InvalidDimensions if @rows <= 0 || @cols <= 0
    raise InvalidDimensions if @maze.length != @rows
    @maze.each { |r| raise DifferentSizedColumn if r.length != @cols }

    # check fields
    possible_fields = [" ", "#", "s", "e"]
    current_row = 0
    @maze.each do |r|
      current_col = 0
      r.each do |c|
        raise InvalidCell unless possible_fields.include?(c)
        if ["s", "e"].include?(c)
          possible_fields.delete(c)
          @start_point = [current_row, current_col] if c == "s"
          @end_point = [current_row, current_col] if c == "e"
        end
        current_col += 1
      end
      current_row += 1
    end
    raise NoStartOrExit if possible_fields.include?("s") or possible_fields.include?("e")
  end

  # Find a solution for the maze by recursive backtrack
  def find_solution
    if solve(@start_point[0], @start_point[1])
      @maze.each { |row| puts row.join("") }
    else
      puts "no solution found"
    end
  end

  def solve(row, col)
    return false if col < 0 || col == @cols || row < 0 || row == @rows
    return true if row == @end_point[0] && col == @end_point[1]
    return false if @maze[row][col] == "*" or @maze[row][col] == "#"

    @maze[row][col] = "*"
    solve(row, col - 1) || solve(row, col + 1) || solve(row - 1, col) || solve(row + 1, col)
  end
end

maze = Maze.new("maze.txt")
maze.find_solution
