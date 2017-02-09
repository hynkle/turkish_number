require 'test_helper'

class TurkishNumberTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::TurkishNumber::VERSION
  end

  mappings = {
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
    11 => 'on bir',
    20 => 'yirmi',
    21 => 'yirmi bir',
    30 => 'otuz',
    40 => 'kırk',
    50 => 'elli',
    60 => 'altmış',
    70 => 'yetmiş',
    80 => 'seksen',
    90 => 'doksan',
    100 => 'yüz',
    101 => 'yüz bir',
    111 => 'yüz on bir',
    200 => 'iki yüz',
    1_000 => 'bin',
    1_001 => 'bin bir',
    1_011 => 'bin on bir',
    1_111 => 'bin yüz on bir',
    2_000 => 'iki bin',
    1_000_000 => 'bir milyon',
    1_000_000_000 => 'bir milyar',
    603_862_955_583 =>  'altı yüz üç milyar sekiz yüz altmış iki milyon dokuz yüz elli beş bin beş yüz seksen üç',
    999_999_999_999 => 'dokuz yüz doksan dokuz milyar dokuz yüz doksan dokuz milyon dokuz yüz doksan dokuz bin dokuz yüz doksan dokuz',
    -1000 => 'eksi bin',
    -999_999 => 'eksi dokuz yüz doksan dokuz bin dokuz yüz doksan dokuz',
    -1_938_881 => 'eksi bir milyon dokuz yüz otuz sekiz bin sekiz yüz seksen bir'
  }

  mappings.each do |number, given_words|
    define_method "test_#{number}" do
      computed_words = TurkishNumber.to_words(number)
      assert_equal given_words, computed_words, "#{number} into Turkish words"
    end
  end

  def test_cannot_handle_trillions
    assert_raises(ArgumentError) do
      TurkishNumber.to_words(1_000_000_000_000)
    end
  end

  def test_cannot_handle_negative_trillions
    assert_raises(ArgumentError) do
      TurkishNumber.to_words(-1_000_000_000_000)
    end
  end

end
