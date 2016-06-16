require "turkish_number/version"

module TurkishNumber

  MINIMUM_HANDLEABLE_NUMBER = 0
  MAXIMUM_HANDLEABLE_NUMBER = 999_999_999_999
  BREAKNUMBERS = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 1_000, 1_000_000, 1_000_000_000].sort!.reverse!.freeze
  MAPPINGS = {
    0 => 'sıfır',
    1 => 'bir',
    2 => 'iki',
    3 => 'üç',
    4 => 'dört',
    5 => 'beş',
    6 => 'altı',
    7 => 'yedi',
    8 => 'sekiz',
    9 => 'dokuz',
    10 => 'on',
    20 => 'yirmi',
    30 => 'otuz',
    40 => 'kırk',
    50 => 'elli',
    60 => 'altmış',
    70 => 'yetmiş',
    80 => 'seksen',
    90 => 'doksan',
    100 => 'yüz',
    1_000 => 'bin',
    1_000_000 => 'milyon',
    1_000_000_000 => 'milyar'
  }.freeze

  def self.to_words(number)
    begin
      number = Integer(number)
    rescue ArgumentError
      raise ArgumentError, "unable to convert #{number.inspect} to an Integer"
    end

    raise ArgumentError, "#{number} is too small" if number < MINIMUM_HANDLEABLE_NUMBER
    raise ArgumentError, "#{number} is too big" if number > MAXIMUM_HANDLEABLE_NUMBER

    return MAPPINGS.fetch(number) if MAPPINGS.key?(number)

    breaknumber = BREAKNUMBERS.detect { |b| b < number }
    unless breaknumber
      raise "no breaknumber found that is less than #{number}"
    end

    breaknumber_multiplier = number / breaknumber
    
    leftovers = number - (breaknumber * breaknumber_multiplier)

    components = [breaknumber]
    components << leftovers unless leftovers == 0
    components.unshift(breaknumber_multiplier) unless breaknumber_multiplier == 1

    components.map{|component_number| TurkishNumber.to_words(component_number)}.join(' ')
  end

end
