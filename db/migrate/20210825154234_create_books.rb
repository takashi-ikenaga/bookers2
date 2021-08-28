class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.string :profile_image_id
      t.timestamps
    end
  end
end
