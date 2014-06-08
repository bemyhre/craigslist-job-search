class SearchesController < ApplicationController
	def new
	end

	def create
	    @search = Search.new(params[:search])
	    if @search.save
	      redirect_to root_path
	  	end
	end
end