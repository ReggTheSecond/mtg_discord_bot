require "test/unit"
require_relative '../src/whats_the_pick.rb'
require_relative '../src/commands.rb'

class CommandsTester < Test::Unit::TestCase
  def test_add_feature_request()
    assert_equal("18/04/17:Feature: New Feature", Commands.new().add_feature_request("request:New Feature:"))
  end
end
