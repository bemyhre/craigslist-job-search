class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :listing_id
      t.string :title
      t.string :url
      t.string :city
      t.datetime :posted_date
      t.belongs_to :search
      t.timestamps
    end
  end

end