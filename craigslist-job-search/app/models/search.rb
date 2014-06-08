require 'open-uri'
require 'nokogiri'

class Search < ActiveRecord::Base
	attr_accessible :search_name, :string_of_terms, :cities
	has_many :listings

	def execute_search(string_of_terms, string_of_cities)
		@job_master_list={}
		time = identify_time
		cities = parse_out_cities(string_of_cities)
		cities.each do |city|
			url = construct_search_url_to_query(city,string_of_terms)
			open_search_page=get_page(url)
			#parse_page_details(open_search_page, city)

		end
		# query_urls	
		# populate_listings
		# render_results
	end

	def identify_time
		Time.now-200000
	end

	def parse_out_cities(string)
		string.split
	end

	def parse_page_details(page, city)
		# for element in page 
		# 	url_string="http://#{city}.craigslist.org#{element.attr("href")}"
		# 	if qualified_url?(element)

		# 	end
		# end
	end

	def construct_search_url_to_query(city,string_of_terms)
		"http://#{city}.craigslist.org/search/jjj?query=#{string_of_terms}"
	end

	def get_page(url)
		Nokogiri::HTML(open(url)).css("a")
	end
end

