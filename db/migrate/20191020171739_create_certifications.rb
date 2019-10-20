class CreateCertifications < ActiveRecord::Migration[5.2]
  def change
    create_table :certifications do |t|
    	t.belongs_to :user, index: true
    	t.string :name
    	t.date :start_date
    	t.date :end_date
    	t.string :institute_name
    	t.string :location
    	t.text :description
      t.timestamps
    end
  end
end
