class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :listing_id
      t.string :title
      t.belongs_to :supplier
      t.timestamps
    end
  end

end