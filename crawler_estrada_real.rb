# encoding: utf-8
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'byebug'
require 'csv'
require 'logger'

class CrawlerEstradaReal
	LOG_FILE = Logger.new('./logs/log.log') #init log file
	LOG_STDOUT = Logger.new(STDOUT) #init log stdout


# @pool = []
# @lines = []
# @w_lines = []

	attr_reader :lines, :w_lines
	attr_accessor :file, :result_file

	def initialize(file_base_points, result_file = "file.csv")
		@lines = []
		@w_lines = []
		@file = File.open( file_base_points )
		@file.each{|line| @lines << line}
		@result_file = result_file
	end
	
	
	def run
		log "STARTING GET POINTS"
		@lines.each_with_index do |url, index|
		  # @pool << Thread.new {
		    get_point(url, index)
		  # }
		end
		log "FINISHING GET POINTS"
	end

	def generate_file_result
		log "GENERATIING FILE CSV"
		CSV.open(@result_file, "wb") do |csv|
		  csv << ["lat", "log", "title"]
		  @w_lines.each do |line|
		  	csv << line
		  end
		end
		log "FILE #{@result_file} GENERATED WITH SUCCESS"
	end

	private
	def get_point(url, index)
		begin
			log "<<<<<<<GET POINT #{url}. URL #{index} to #{@lines.size}"
			
			html = open( url.gsub("\n","") ).read

			pag = Nokogiri::HTML(open( url.gsub("\n","") ))

			title = pag.css(".guide-h1").text.gsub("\n", ' ').squeeze(' ')
			description = pag.css(".guide-content-text").text.gsub("\n", ' ').squeeze(' ')

			lat = -(html[/data-lat=(\D).*/][/"-(\d).*?"/][/\d.*?\"/]).to_f
			lng = -(html[/data-lng=(\D).*/][/"-(\d).*?"/][/\d.*?\"/]).to_f


			@w_lines << [lat,lng, title, description]

			log "<<<<<<<SUCCESS GET POINT #{url}."
		rescue Exception => e
			log ([e.message]+e.backtrace).join($/), "error"
		end
	end

	def log(msg, priority = "info")
		LOG_FILE.send(priority, msg)
		LOG_STDOUT.send(priority, msg)
	end
		
end