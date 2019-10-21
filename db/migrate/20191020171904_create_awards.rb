class CreateAwards < ActiveRecord::Migration[5.2]
  def change
    create_table :awards do |t|
    	t.belongs_to :user, index: true
    	t.string :institute_name, null: false
    	t.string :award_name, null: false
    	t.date :award_date, null: false
    	t.text :description
      t.timestamps
    end
  end
end
