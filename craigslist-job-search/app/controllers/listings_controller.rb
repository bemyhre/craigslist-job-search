class ListingsController < ApplicationController
	def index
		@listings=Listing.all
		@search=Search.new
	end
end