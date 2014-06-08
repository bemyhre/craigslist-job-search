class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :listing_id
      t.string :title
      t.timestamps
    end
  end

end