require_relative 'tile.rb'
require 'colorize'

class Board
    attr_reader :grid

    VALUES = (1..9).to_a.map(&:to_s)

    def self.from_file
        start_arr = []
        text_name = 'sudoku1.txt'
        File.open(text_name, 'r').each_line do |line|
            start_arr  << line.chomp
        end
        Board.grid_from_array(start_arr)
    end

    def self.grid_from_array(arr)
        arr.map {|row| Board.string_to_array(row)}
    end

    def self.string_to_array(str)
        str.split("").map do |ele|
            if ele=='0'
                Tile.new(ele,false)
            else
                Tile.new(ele,true)
            end
        end
    end

    def initialize
        @grid=Board.from_file
    end

    def [](pos)
        row,col=pos
        grid[row][col]
    end

    def []=(pos,val)
        tile=self[pos]
        row,col=pos
        if !tile.given
            @grid[row][col].value=val
            return true
        else
            return false
        end
    end

    def render
        value_grid = self.grid_value_color
        puts "  0 1 2 3 4 5 6 7 8".colorize(:red)
        value_grid.each_with_index {|row,i| puts "#{i.to_s.colorize(:red)} #{row.join(" ")}"}
    end

    def grid_value_color
        grid.map do |row|
            row.map {|ele| ele.to_s}
        end
    end

    def grid_value
        grid.map do |row|
            row.map {|ele| ele.value}
        end
    end

    def solved?
        
        self.row_solved? && self.col_solved? && self.square_solved?
    end

    def sub_solved?(portion)
        portion.all? {|row| row.sort == VALUES}
    end

    def row_solved?
        grid_value = self.grid_value
        self.sub_solved?(grid_value)
    end

    def col_solved?
        grid_value = self.grid_value
        self.sub_solved?(grid_value.transpose)    
    end

    def square_solved?
        valid_squares = self.valid_squares    
        self.sub_solved?(valid_squares)
    end

    def valid_squares
        valid_squares = []
        [0, 3, 6].each do |row_idx|
            [0, 3, 6].each do |col_idx|
                valid_squares << self.get_one_sqaure(row_idx,col_idx)
            end
        end
        valid_squares
    end

    def get_one_sqaure(row_idx,col_idx)
        one_square = []
        (row_idx...row_idx + 3).each do |i|
            (col_idx...col_idx + 3).each do |j|
                one_square << self[[i, j]].value
            end
        end
        one_square
    end


end

