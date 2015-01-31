class CreateLinkedinProfiles < ActiveRecord::Migration
  def change
    # Untracked:
    # certifications
    # organizations
    # groups
    # skills
    # languages
    # recommended_visitors
    create_table :linkedin_profiles do |t|
      t.string :link, null: false
      t.boolean :advisor, default: false
      t.string :first_name
      t.string :last_name
      t.text :summary
      t.text :page
      t.string :picture
      t.string :title
      t.string :industry
      t.string :linkedin_url
      t.string :location
      t.string :country
      t.string :client_type
      t.timestamps null: false
    end

    create_table :schools do |t|
      t.string :name
      t.string :description
      t.string :period
      t.belongs_to :linkedin_profile, index: true
    end

    create_table :websites do |t|
      t.string :name
      t.belongs_to :linkedin_profile, index: true
    end

    create_table :companies do |t|
      t.boolean :current
      t.string :title
      t.string :company
      t.string :description
      t.date :start_date
      t.date :end_date
      t.string :linkedin_company_url
      t.string :name

      t.belongs_to :linkedin_profile, index: true
    end

    add_index :linkedin_profiles, :link
  end
end
