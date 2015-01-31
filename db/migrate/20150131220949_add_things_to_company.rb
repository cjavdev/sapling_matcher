class AddThingsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :website, :string
    add_column :companies, :industry, :string
    add_column :companies, :headquarters, :string
    add_column :companies, :company_size, :string
    add_column :companies, :founded, :string
    add_column :companies, :address, :string
  end
end
