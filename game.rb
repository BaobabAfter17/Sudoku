require_relative './board.rb'

class Game

    def initialize
        @board=Board.new
    end

    def play
        until board.solved?
            system("clear")
            board.render
            pos=self.get_position
            val=self.get_value
            board[pos]=val
        end
        board.render
        puts "YOU WON!"
    end

    def get_position
        position=[]
        until self.valid_position?(position)
            puts "enter a position: (e.g: 1 2)"
            position_str=gets.chomp.split(" ")
            position=position_str.map(&:to_i)
        end
        position
    end

    def valid_position?(pos)
        pos.length==2 && pos.all?{|idx| idx.between?(0,8)}
    end

    def get_value
        value=""
        until self.valid_value?(value)
            puts "enter a value: (e.g: 7)"
            value=gets.chomp
        end
        value
    end

    def valid_value?(val)
        ("0".."9").to_a.include?(val)
    end
    private
    attr_accessor :board
end

if $PROGRAM_NAME == __FILE__
    g=Game.new
    g.play
end
