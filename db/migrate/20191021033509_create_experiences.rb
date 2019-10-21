class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
    	t.belongs_to :user, index: true
    	t.string :title
    	t.string :company_name
    	t.date :start_date
    	t.date :end_date
    	t.string :location
    	t.string :description
      t.timestamps	
    end
  end
end
