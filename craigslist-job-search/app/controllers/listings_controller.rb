class ListingsController < ApplicationController
	def index

		@search=Search.new
		@search.execute_search("ruby","sfbay sandiego orangecounty")
		@listings=Listing.find(:all, :order => "posted_date DESC")
	end
end