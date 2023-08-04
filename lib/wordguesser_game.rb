class WordGuesserGame
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :guessed_letter

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @guessed_letter = ''
  end

  def word
    @word
  end

  def guesses()
    @guesses
  end

  def wrong_guesses()
    @wrong_guesses
  end

  def guess(letter)
    raise ArgumentError if letter.nil? || letter == '' || !letter.match?(/[a-zA-Z]/)
    letter.downcase!
    return false if @guesses.include?(letter) or @wrong_guesses.include?(letter)
    if @word.include?(letter)
      @guesses += letter
      return true
    else
      @wrong_guesses += letter
      return true
    end
    
  end

  def guess_word

  end

  def word_with_guesses
    counter = 0
    @word.split('').each do |letter|
      counter += 1
      @guesses.split('').each do |j|
        if letter == j
          @guessed_letter += letter
        end
      end
      if @guessed_letter.length < counter
        @guessed_letter += "-"
      end
    end
    return @guessed_letter
  end

  def check_win_or_lose
    if !word_with_guesses.include?("-")
      return :win
    elsif @guesses.length + @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

  def guessing

  end

end
