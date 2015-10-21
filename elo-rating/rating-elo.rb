$USE_FIDE = true

# Random variate for generating initial ELO ratings.
#
class Array
  def sum
    self.inject(0, &:+)
  end
end

def rnormal(mean, sd)
  mean + (Math.sqrt(-2 * Math.log(rand)) * Math.cos(2 * Math::PI * rand)) * sd
end

# Exponential sampling.
def rexp(rate)
  -Math.log(rand) / rate
end

# Gamma sampling.
def rgamma(k, lambd)
  ((1..k).map { rexp(lambd) }).sum
end

# Customized random variate.
def rvariate
  r = rand
  if rand < 0.33
    x = rgamma(8, 5)
  elsif rand < 0.66
    x = rnormal(2.5, 1)
  else
    x = rnormal(1, 0.5)
  end
  650 + 300 * x
end

# Player stores its matches and, periodically, updates its ELO rating,
# with FIDE's K factor.
#
class Player
  attr_accessor :elo, :first_elo, :matches, :wins, :losses

  def initialize(initial_elo)
    @elo, @first_elo = initial_elo, initial_elo
    @matches = []
    @wins = 0
    @losses = 0
  end

  def update_elo
    # Find K factor. (FIDE's correction.)
    if $USE_FIDE
      k = @elo < 2400 ? 15 : 10
      k = 30 if total < 30
    else
      k = 32
    end

    # Update ELO.
    expected_score = 0
    result = 0
    @matches.each do |m|
      expected_score += 1 / (1 + 10**((m[:op_elo] - m[:my_elo]).to_f / 400))
      result += m[:result]
    end
    @elo += k * (result - expected_score)

    # Dump hanging matches.
    @matches.each do |m|
      if m[:result] == 1
        @wins += 1
      else
        @losses += 1
      end
    end
    @matches.clear
  end

  def total
    @wins + @losses
  end
end

# Game. It is possible to run a tournament and list final rankings.
#
class Game
  attr_accessor :players, :matches

  def initialize(num_players)
    @players = (1..num_players).collect { Player.new(rvariate) }
    @matches = 0.upto(players.length - 1).to_a.combination(2).to_a
  end

  def run_tournament(update_per_match = true)
    @matches.each do |match|
      # Players.
      p1 = @players[match[0]]
      p2 = @players[match[1]]
      
      # Ratings.
      p1_exp = 1 / (1 + 10**((p2.elo - p1.elo).to_f / 40))
      p2_exp = 1 - p1_exp
      
      # Run the match.
      outcome = rand < p1_exp ? :a : :b

      # Record match.
      if outcome == :a
        p1.matches << { :my_elo => p1.elo, :op_elo => p2.elo, :result => 1 }
        p2.matches << { :my_elo => p2.elo, :op_elo => p1.elo, :result => 0 }
      else
        p1.matches << { :my_elo => p1.elo, :op_elo => p2.elo, :result => 0 }
        p2.matches << { :my_elo => p2.elo, :op_elo => p1.elo, :result => 1 }
      end

      # Update their ELO ratings.
      if update_per_match
        p1.update_elo
        p2.update_elo
      end
    end
  end

  # List players sorted by their ELO ratings.
  def rankings
    @players.sort_by(&:elo).reverse.each do |p|
      felt_rose = p.elo > p.first_elo ? "rose" : "felt"
      puts "#{'%.0f' % p.elo} #{felt_rose} from #{'%0.f' % p.first_elo}, #{p.wins} / #{p.total}"
    end
  end
end

# Instance.
g = Game.new 300
5.times { g.run_tournament(true) }
g.rankings
