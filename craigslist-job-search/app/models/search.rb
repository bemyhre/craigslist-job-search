class Search < ActiveRecord::Base
	attr_accessible :search_name, :string_of_terms, :cities
	has_many :listings

	def execute_search(string_of_terms, cities)
		time = identify_time
		puts "%"*50
		puts time
		puts "$"*50
		# parse_out_cities
		# create_search_urls_to_query
		# query_urls
		# populate_listings
		# render_results
	end

	def identify_time
		return Time.now-200000
	end
end

