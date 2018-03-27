require "test/unit"
require_relative '../src/searching_gatherer.rb'

class SearchGathererTester < Test::Unit::TestCase
  def test_parse_card_name()
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon&type:creature&text:deathtouch}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon&type:creature}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{name:Dragon}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{type:creature&name:Dragon&text:deathtouch&colour:blue}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{type:creature&text:deathtouch&name:Dragon}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{type:creature&name:Dragon}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{type:creature&name:Dragon&text:deathtouch}}"))
    assert_equal("Dragon", SearchGatherer.new().parse_card_name("{{colour:blue&name:Dragon}}"))
    assert_equal("", SearchGatherer.new().parse_card_name("{{colour:blue}}"))
  end

  def test_parse_card_type()
    assert_equal("creature", SearchGatherer.new().parse_card_type("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("creature", SearchGatherer.new().parse_card_type("{{name:Dragon&type:creature&text:deathtouch}}"))
    assert_equal("creature", SearchGatherer.new().parse_card_type("{{name:Dragon&type:creature}}"))
    assert_equal("creature", SearchGatherer.new().parse_card_type("{{type:creature&name:Dragon&text:deathtouch&colour:blue}}"))
    assert_equal("creature", SearchGatherer.new().parse_card_type("{{type:creature&text:deathtouch&name:Dragon}}"))
    assert_equal("creature", SearchGatherer.new().parse_card_type("{{type:creature&name:Dragon}}"))
    assert_equal("creature", SearchGatherer.new().parse_card_type("{{type:creature&name:Dragon&text:deathtouch}}"))
    assert_equal("", SearchGatherer.new().parse_card_type("{{colour:blue}}"))
  end

  def test_parse_card_subtype()
    assert_equal("Elder", SearchGatherer.new().parse_card_subtype("{{name:Dragon&type:creature&sub:Elder&text:deathtouch&colour:blue}}"))
    assert_equal("Elder", SearchGatherer.new().parse_card_subtype("{{name:Dragon&type:creature&text:deathtouch&sub:Elder}}"))
    assert_equal("Elder", SearchGatherer.new().parse_card_subtype("{{sub:Elder&type:creature}}"))
    assert_equal("Elder", SearchGatherer.new().parse_card_subtype("{{type:creature&name:Dragon&sub:Elder&text:deathtouch&colour:blue}}"))
    assert_equal("Elder", SearchGatherer.new().parse_card_subtype("{{type:creatur&sub:Elder&text:deathtouch&name:Dragon}}"))
    assert_equal("Elder", SearchGatherer.new().parse_card_subtype("{{sub:Elder}}"))
    assert_equal("Elder", SearchGatherer.new().parse_card_subtype("{{type:creature&name:Dragon&text:deathtouch&sub:Elder}}"))
    assert_equal("", SearchGatherer.new().parse_card_subtype("{{colour:blue}}"))
  end

  def test_parse_card_text()
    assert_equal("deathtouch", SearchGatherer.new().parse_card_text("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("deathtouch", SearchGatherer.new().parse_card_text("{{name:Dragon&type:creature&text:deathtouch}}"))
    assert_equal("deathtouch", SearchGatherer.new().parse_card_text("{{type:creature&name:Dragon&text:deathtouch&colour:blue}}"))
    assert_equal("deathtouch", SearchGatherer.new().parse_card_text("{{type:creature&text:deathtouch&name:Dragon}}"))
    assert_equal("deathtouch", SearchGatherer.new().parse_card_text("{{type:creature&name:Dragon&text:deathtouch}}"))
    assert_equal("", SearchGatherer.new().parse_card_type("{{colour:blue}}"))
  end

  def test_parse_card_colour()
    assert_equal("blue", SearchGatherer.new().parse_card_colour("{{name:Dragon&type:creature&text:deathtouch&colour:blue}}"))
    assert_equal("blue", SearchGatherer.new().parse_card_colour("{{type:creature&name:Dragon&text:deathtouch&colour:blue}}"))
    assert_equal("blue", SearchGatherer.new().parse_card_colour("{{colour:blue&name:Dragon}}"))
    assert_equal("", SearchGatherer.new().parse_card_colour("{{ame:Dragon}}"))
  end

  def test_parse_card_set()
    assert_equal("ORI", SearchGatherer.new().parse_card_set("{{name:Dragon&type:creature&text:deathtouch&colour:blue&set:ORI}}"))
    assert_equal("ORI", SearchGatherer.new().parse_card_set("{{set:ORI&type:creature&name:Dragon&text:deathtouch&colour:blue}}"))
    assert_equal("ORI", SearchGatherer.new().parse_card_set("{{colour:blue&set:ORI&name:Dragon}}"))
    assert_equal("", SearchGatherer.new().parse_card_set("{{se:ORI}}"))
  end
end
