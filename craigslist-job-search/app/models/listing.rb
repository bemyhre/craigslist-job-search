class Listing < ActiveRecord::Base
	attr_accessible :listing_id, :title, :posted_date
	has_one :searches

end