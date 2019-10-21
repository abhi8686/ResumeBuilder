class CreateProfileImages < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_images do |t|
    	t.string :original
    	t.string :square
      t.timestamps
    end
  end
end
