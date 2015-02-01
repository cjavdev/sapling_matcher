class AddCompanyMatch < ActiveRecord::Migration
  def change
    add_column :profile_matches, :company, :boolean, default: false
  end
end
