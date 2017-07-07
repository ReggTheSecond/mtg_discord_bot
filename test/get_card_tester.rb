require "test/unit"
require_relative '../src/whats_the_pick.rb'
require_relative '../src/get_card.rb'

class Card_Searcher_Tester < Test::Unit::TestCase
  def test_get_card_name()
    assert_equal("Goblin Rabblemaster", Card_Searcher.new().get_card_name("Goblin Rabblemaster"))
  end

  def test_get_card_link()
    assert_equal("http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=383258&type=card", Card_Searcher.new().get_card_link("Goblin Rabblemaster"))
  end

  def test_get_split_card()
    assert_equal("http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=107423&type=card", Card_Searcher.new().get_split_card("rise//fall"))
  end

  def test_get_specific_set()
    assert_equal("http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=202687&type=card", Card_Searcher.new().get_specific_set("blistergrub", "SOM"))
  end

  def test_get_nickname()
    assert_equal("dig through time", Card_Searcher.new().get_nickname("dig"))
  end
end
