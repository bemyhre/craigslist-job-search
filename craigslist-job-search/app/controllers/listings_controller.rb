class ListingsController < ApplicationController
	def index
		@listings=Listing.all
		@search=Search.new
		@search.execute_search(1,2)
	end
end