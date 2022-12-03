class Match
    def initialize(player_one, player_two)
        @player_one = player_one
        @player_two = player_two
    end

    def player_two_shape
        shape[@player_two]
    end

    def player_one_shape
        shape[@player_one]
    end

    def shape
        { :A => :rock, :X => :rock, :B => :paper, :Y => :paper, :C => :scissor, :Z => :scissor }
    end

    def shape_points
        { :rock => 1, :paper => 2, :scissor => 3 }
    end

    def result_points
        { :win => 6, :lose => 0, :draw => 3 }
    end

    def winning_rules
        { :rock => :scissor, :paper => :rock, :scissor => :paper }
    end

    def result
        return :win if winning_rules[player_two_shape] == player_one_shape
        return :draw if player_one_shape == player_two_shape
        return :lose
    end

    def calculate
        match_points = result_points[result]
        shape_points[player_two_shape] + match_points
    end
end

class AutomatedMatch < Match
    def initialize(player_one, expected_result)
        @expected_result = expected_result
        super
    end

    def player_two_shape
        self.send match_result[@expected_result]
    end

    def match_result
        { :X => :lose, :Y => :draw, :Z => :win }
    end

    def win
        winning_rules.key(player_one_shape)
    end

    def lose
        winning_rules[player_one_shape]
    end

    def draw
        player_one_shape
    end
end


class Game
    def initialize(input_path, automated: false)
        @input_path = input_path
        @automated = automated
    end

    def play
        File.read(@input_path).split("\n").map do |round|
            elf, human = round.split
            match = if @automated
                AutomatedMatch.new(elf.to_sym, human.to_sym)
            else
                Match.new(elf.to_sym, human.to_sym)
            end
            match.calculate
        end.sum
    end
end


game = Game.new("rock-paper-scissors-lizard-spock.txt")
p "Part one: #{game.play}"
automated_game = Game.new("rock-paper-scissors-lizard-spock.txt", automated: true)
p "Part two: #{automated_game.play}"