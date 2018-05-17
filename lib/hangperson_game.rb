class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = "" 
     @word_with_guesses =""
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(character)
     raise ArgumentError if not character =~ /^[a-zA-Z]$/
    
    character.downcase!
    return false if guesses.include? character
    return false if wrong_guesses.include? character
      if word.include? character
        guesses << character
        return true
      else not word.include? character and not wrong_guesses.include? character
        wrong_guesses << character
        return true
      end
  end 
  
  
  
  def word_with_guesses
    if guesses.empty?
      '-' * word.length
    else 
      word.gsub(/[^#{guesses}]/, '-')
    end
  end
  
  
  def check_win_or_lose
    
    return :lose if wrong_guesses.length == 7
    return :win if !(word_with_guesses.include?('-'))
    return :play
  end
  
  
end
