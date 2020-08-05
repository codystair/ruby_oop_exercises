class GuessingGame
  attr_reader :guesses, :low, :high, :range

  def initialize(low, high)
    @low = low
    @high = high
    @range = (low..high)
    reset
  end

  def reset
    @guesses = Math.log2(range.size).to_i + 1
    @number = rand(range)
    @guess = nil
  end

  def remaining_guesses
    puts "You have #{guesses} guesses remaining."
  end

  def player_guess
    loop do
      puts "Enter a number between #{low} and #{high}:"
      @guess = gets.chomp.to_i
      break if valid_guess?(@guess)
      puts "Invalid guess."
      puts ""
    end
  end

  def valid_guess?(guess)
    guess.class == Integer && range.cover?(guess)
  end

  def evaluate_guess
    if win?
      puts "That's the number!"
      puts ""
    elsif @guess > @number
      puts "Your guess is too high."
      puts ""
      @guesses -= 1
    else
      puts "Your guess is too low."
      puts ""
      @guesses -= 1
    end
  end

  def win?
    @guess == @number
  end

  def game_over?
    win? || @guesses == 0
  end

  def display_results
    if win?
      puts "You won!"
    else
      puts "You have no more guesses.  You lost!"
    end
  end

  def play
    reset
    loop do
      remaining_guesses
      player_guess
      evaluate_guess

      break if game_over?
    end
    display_results
  end
end

game = GuessingGame.new(501, 1500)
game.play
game.play
