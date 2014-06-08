class Listing < ActiveRecord::Base
	attr_accessible :listing_id, :title
	has_one :searches

end