class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
    	t.string :project_name, null: false
    	t.string :skills, null: false
    	t.string :app_link
    	t.date :start_date, null: false
    	t.date :end_date
    	t.text :description, null: false
      t.belongs_to :user, index: true
      t.belongs_to :experience, index: true
      t.timestamps
    end
  end
end
