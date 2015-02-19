require_relative '../../test_helper'

require_relative '../../../lib/racket/misc/lv'

class TestLV < Minitest::Test
	def test_init
		Racket::Misc::LV.new 2
		Racket::Misc::LV.new 2, 4, 1, 1, 6
	end

	def test_decode
		t1 = Racket::Misc::LV.new 2
		s1 = "\x00\x0b\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67"
		t1.decode! s1
		assert_equal t1.lengths[0], 11
		assert_equal t1.values[0], 'spoofed.org'

		t2 = Racket::Misc::LV.new 1, 2, 2, 4
		s2 = "\x02\xab\xcd\x00\x01\xff\x00\x04\xde\xad\xba\xbe\x00\x00\x00\x0a\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffwtf?".force_encoding 'ASCII-8BIT'
		t2.decode! s2
		assert_equal 2, t2.lengths[0]
		assert_equal "\xAB\xCD".force_encoding('ASCII-8BIT'), t2.values[0]
		assert_equal 1, t2.lengths[1]
		assert_equal "\xff".force_encoding('ASCII-8BIT'), t2.values[1]
		assert_equal 4, t2.lengths[2]
		assert_equal "\xde\xad\xba\xbe".force_encoding('ASCII-8BIT'), t2.values[2]
		assert_equal 10, t2.lengths[3]
		assert_equal "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff".force_encoding('ASCII-8BIT'), t2.values[3]
		assert_equal 'wtf?', t2.rest
	end

	def test_encode
		t1 = Racket::Misc::LV.new 2
		s1 = "\x00\x0bspoofed.org"
		t1.decode! s1
		assert_equal t1.encode, s1
		assert_equal "#{t1}", s1

		t2 = Racket::Misc::LV.new 1, 2, 2
		s2 = "\x01\xff\x00\x02\xff\xff\x00\x0bspoofed.org\xff\xff\xffwtf?".force_encoding 'ASCII-8BIT'
		t2.decode! s2
		assert_equal t2.encode, s2.slice(0, s2.size - 7)
		assert_equal "#{t2}", s2.slice(0, s2.size - 7)

		t3 = Racket::Misc::LV.new 1, 1, 1
		t3.lengths = [2, 2, 2]
		t3.values = %w(ww tt ff)
		assert_equal t3.encode, "\x02ww\x02tt\x02ff"

		t3 = Racket::Misc::LV.new 1, 1, 1
		t3.lengths = [2, 2, 4]
		t3.values = %w(ww tt ff)
		assert_equal t3.encode, "\x02ww\x02tt\x04ff\00\00"
	end
end
