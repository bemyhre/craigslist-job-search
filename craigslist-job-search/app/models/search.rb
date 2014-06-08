class Search < ActiveRecord::Base
	attr_accessible :search_name, :string_of_terms, :cities
	has_many :listings
end

