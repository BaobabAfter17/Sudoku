require 'colorize'
class Tile
    attr_accessor :value 
    attr_reader :given
    def initialize(value, given)
        @value=value
        @given=given
    end

    def to_s
        if given
            return value.to_s.colorize(:green)
        else
            return value.to_s 
        end
    end
end