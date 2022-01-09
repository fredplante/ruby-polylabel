# frozen_string_literal: true

require "test_helper"
require "json"

class PolylabelTest < Minitest::Test
  def test_short
    short = JSON.parse(File.read("test/fixtures/short.json"))

    result = Polylabel.compute(short, 1)

    assert_equal(3317.546875, result[:x])
    assert_equal(1330.796875, result[:y])
    assert_equal(5.4406249999999545, result[:distance])
  end

  def test_finds_pole_of_inaccessibility_for_water1_and_precision_1
    water1 = JSON.parse(File.read("test/fixtures/water1.json"))

    result = Polylabel.compute(water1, 1)

    assert_equal(3865.85009765625, result[:x])
    assert_equal(2124.87841796875, result[:y])
    assert_equal(288.8493574779127, result[:distance])
  end

  def test_works_on_degenerate_polygons
    result = Polylabel.compute([[[0, 0], [1, 0], [2, 0], [0, 0]]])

    assert_equal(0, result[:x])
    assert_equal(0, result[:y])
    assert_equal(0, result[:distance])

    result = Polylabel.compute([[[0, 0], [1, 0], [1, 1], [1, 0], [0, 0]]])

    assert_equal(0, result[:x])
    assert_equal(0, result[:y])
    assert_equal(0, result[:distance])
  end
end
