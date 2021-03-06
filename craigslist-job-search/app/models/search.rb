require 'open-uri'
require 'nokogiri'

class Search < ActiveRecord::Base
	attr_accessible :search_name, :string_of_terms, :cities
	attr_accessor :job_master_list, :string_of_terms
	has_many :listings


	def execute_search(string_of_terms, string_of_cities)
		@string_of_terms = string_of_terms
		@job_master={}
		time = identify_time
		cities = parse_out_cities(string_of_cities)
		cities.each do |city|
			url = construct_search_url_to_query(city,string_of_terms)
			open_search_page=get_page(url)
			parse_page_details(open_search_page, city)
		end
		remove_existing_listings
		merge_posting_dates
		remove_nil_listings
		insert_into_listings
	end

	def parse_page_details(page, city)
		for element in page 
		      if desired_url?(element)
		        @job_master.merge!("#{element.attr('href')}"=>construct_inner_details(element, city))
		      end
		end
	end

	def merge_posting_dates  #aaahhh don't like this mess.
		@job_master.each do |key,value|
			listing_page=Nokogiri::HTML(open(value[:url])).css("p")
			for element in listing_page
				time_element = element.css('time').text
	      		if time_element!=""&&(time_element.to_datetime>identify_time)
		      	 	post_time =Time.parse(element.css('time').text).to_datetime
		      	 	@job_master[key].merge!(post_time: post_time)
      			end
  			end
		end
	end

	def remove_nil_listings
		@job_master.delete_if do |key,value|
			value[:post_time]==nil
		end
	end

	def insert_into_listings
		@job_master.each do |key,value|
			puts value[:post_time]
			x=Listing.new
			x.listing_id = key
			x.title = value[:text]
			x.url = value[:url]
			x.city =value[:location]
			x.posted_date = value[:post_time]
			x.save
		end
	end


	def remove_existing_listings
		@job_master.delete_if do |key,value|
			Listing.exists?(:listing_id => key)
		end
	end

	def identify_time
		(Time.now-5000).to_datetime
	end

	def parse_out_cities(string)
		string.split
	end


	def desired_url?(element)
		if (element.attr("href")[0]=="/")&&(element.attr("href")[-1]=="l")&&(element.attr("class")!="i")
			true
		else
			false
		end
	end

	def construct_inner_details(element, city)
		{url: "http://#{city}.craigslist.org#{element.attr('href')}",text: element.text, location: city}
	end

	def construct_search_url_to_query(city,string_of_terms)
		"http://#{city}.craigslist.org/search/jjj?query=#{string_of_terms}"
	end

	def get_page(url)
		Nokogiri::HTML(open(url)).css("a")
	end
end

