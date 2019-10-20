class CreateEducations < ActiveRecord::Migration[5.2]
  def change
    create_table :educations do |t|
    	t.belongs_to :user, index: true
    	t.string :degree, null: false
    	t.date :start_date, null: false
    	t.date :end_date, null: false
    	t.string :school_name,null: false
    	t.string :location, null: false
    	t.text :description
      t.timestamps
    end
  end
end
