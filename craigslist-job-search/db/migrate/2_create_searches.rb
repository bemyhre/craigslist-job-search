class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :search_name
      t.string :string_of_terms
      t.string :cities
      t.timestamps
    end
  end

end