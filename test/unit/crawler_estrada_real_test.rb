require 'test/unit'
require './crawler_estrada_real.rb'
require 'byebug'

class CrawlerEstradaRealTest < Test::Unit::TestCase
	def setup
		@crawler = CrawlerEstradaReal.new("./test/fixtures/links_points.txt")
	end

	def test_quant_points
		assert_equal(4, @crawler.lines.size )
	end

	def test_get_correct_points
		points = CSV.read("./test/fixtures/file.csv")
		@crawler.run

		assert_equal(points[1], @crawler.w_lines[0].map(&:to_s) )
		assert_equal(points[2], @crawler.w_lines[1].map(&:to_s) )
		assert_equal(points[3], @crawler.w_lines[2].map(&:to_s) )
		assert_equal(points[4], @crawler.w_lines[3].map(&:to_s) )
	end
end