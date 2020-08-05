require 'pry'

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.index(rank)
  end

  def <=>(other)
    value <=> other.value
  end
end

class Deck
  attr_reader :cards

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = reset.shuffle
  end

  def reset
    result = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        result << Card.new(rank, suit)
      end
    end
    result
  end

  def draw
    if @cards.empty?
      @cards = reset.shuffle!
      @cards.pop
    else
      @cards.pop
    end
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
