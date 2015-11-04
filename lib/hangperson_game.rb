class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError, 'Argument is not a letter' unless !letter.nil? and letter != '' and letter =~ /^[[:alpha:]]$/

    if word =~ /#{letter}/i and @guesses !~/#{letter}/i
	@guesses += letter.downcase
        return true
    elsif word !~ /#{letter}/i and  @wrong_guesses !~/#{letter}/i
        @wrong_guesses += letter.downcase
        return true
    end
    return false
  end

  def word_with_guesses
    if @guesses == ''
      @word.gsub /[^.]/, '-'
    else
      @word.gsub /[^#{guesses}]/, '-'
    end
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif @word == self.word_with_guesses
      :win
    else
      :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

game = HangpersonGame.new('banana')

puts game.guess('d')
puts game.word_with_guesses
puts game.guess('e')
puts game.word_with_guesses
