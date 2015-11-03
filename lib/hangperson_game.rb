class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    #raise ArgumentError if letter.nil?
    #raise ArgumentError if letter.empty?
    #raise ArgumentError if !(letter =~ /^[a-zA-Z]/)
    if letter.nil? || letter.empty? || !(letter =~ /^[a-zA-Z]/)
      raise(ArgumentError)
    end
    
    if @word.include? letter.downcase
      if @guesses.include? letter.downcase
        false
      else
        @guesses += letter.downcase
        true
      end
    else
      if @wrong_guesses.include? letter.downcase
        false
      else
        @wrong_guesses += letter.downcase
        true
      end
    end
    
  end
  
  def word_with_guesses()
    displayed = ''
    @word.split('').each do |chr|
      if @guesses.include? chr
        displayed += chr
      else
        displayed += '-'
      end
    end
    displayed
  end
  
  def check_win_or_lose()
    if @wrong_guesses.length >= 7
      return :lose
    end 
    
    @word.split('').each do |chr|
      if !@guesses.include? chr
        return :play
      end
    end
    
    return :win
  end
  
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
