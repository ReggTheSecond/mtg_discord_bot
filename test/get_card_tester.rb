require "test/unit"
require_relative '../src/whats_the_pick.rb'
require_relative '../src/get_card.rb'

class Card_SearcherTester < Test::Unit::TestCase
  def test_get_card_name()
    assert_equal("Goblin Rabblemaster", Card_Searcher.new().get_card_name("Goblin Rabblemaster"))
  end
end
