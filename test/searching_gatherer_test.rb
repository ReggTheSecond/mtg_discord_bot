require "test/unit"
require_relative '../src/searching_gatherer.rb'

class SearchGathererTester < Test::Unit::TestCase
  def test_parse_card_name()
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon&type:creature&text:deathtouch}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon&type:creature}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon}}"))
  end

  def parse_card_type()
    assert_equal("Dragon", SearchGatherer.new().parse_card_type("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_type("{{name:Dragon&type:creature&text:deathtouch}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_type("{{name:Dragon&type:creature}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_type("{{name:Dragon}}"))
  end

  def parse_card_text()
    assert_equal("Dragon", SearchGatherer.new().parse_card_text("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_text("{{name:Dragon&type:creature&text:deathtouch}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_text("{{name:Dragon&type:creature}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_text("{{name:Dragon}}"))
  end

  def parse_card_colour()
    assert_equal("Dragon", SearchGatherer.new().parse_card_colour("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_colour("{{name:Dragon&type:creature&text:deathtouch}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_colour("{{name:Dragon&type:creature}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_colour("{{name:Dragon}}"))
  end
end
