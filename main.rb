require './crawler_estrada_real.rb'

class Main
	def self.run(args)
		if args.size != 1 && args.size != 2
			$stdout.puts "Wrong number arguments"
			exit 1
		end
		
		@crawler = CrawlerEstradaReal.new(args[0], args[1])
		@crawler.run
		@crawler.generate_file_result
	end
end