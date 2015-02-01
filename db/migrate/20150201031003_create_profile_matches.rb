class CreateProfileMatches < ActiveRecord::Migration
  def change
    create_table :profile_matches do |t|
      t.integer :advisor_profile_id
      t.integer :potential_client_profile_id
      t.boolean :school, default: false
      t.boolean :location, default: false

      t.timestamps null: false
    end
  end
end
