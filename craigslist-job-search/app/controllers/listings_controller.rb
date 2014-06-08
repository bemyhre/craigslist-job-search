class ListingsController < ApplicationController
	def index
		@listings=Listing.all
		@search=Search.new
		@search.execute_search("ruby","sfbay sandiego")
	end
end