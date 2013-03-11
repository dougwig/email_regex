require 'test/unit'
require 'email_regex'

class EmailRegexTest < Test::Unit::TestCase
  def test_good_addresses
    good = [
    	'doug@example.com',
    	'"doug"@example.com',
    	'"sp sp"@example.com',
    	'"foo"@a,"foo"@b',
    	'foo@example',
    	'foo@[1.2.3.4]',
    	'ipv6@[FEDC:BA98:7654:3210:FEDC:BA98:7654:3210]',
    	'a@b.c,d@e.f',
    	'a@b.c,d@e.f,g@h.i',
    	' a@b.c,d@e.f,g@h.i ',
    	'a@b.c ,   d@e.f,g@h.i',
    	'a@b.c,d@e.f           ,g@h.i',
    	'a@b.c,d@e.f,    g@h.i',
    	'doug-test@a.com',
    	'doug_test@a.com',
    	'doug.test@a.com',
    	'doug+test@a.com',
    	'a@f-w.junk',
    	'a@f_w.junk'       # this is an illegal DNS name, but in common use	
    ]
    good.each do |x|
      assert x =~ EmailRegex::EMAIL_ADDRESS_REGEX
    end
  end
  
  def test_bad_addresses
    bad = [
    	'doug@',
    	'@example.com',
    	'sp sp@example.com',
    	#'doug@[foo.com]',  # not worth the complexity to check for this
    	#'doug@[foo]',      # not worth the complexity to check for this
    	'doug@a,',
    	',doug@a',
    	'a @b',
    	'a@ b',
    	'""@a',
    	'doug',
    	'doug,jim',
    	'"hello`reboot`goodbye"@example.com'
    ]
    bad.each do |x|
      assert (not x =~ EmailRegex::EMAIL_ADDRESS_REGEX)
    end
  end
end

