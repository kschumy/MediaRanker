class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :title
      t.string :category
      t.date :publication_year
      t.string :description
      t.string :creator

      t.timestamps
    end
  end
end
