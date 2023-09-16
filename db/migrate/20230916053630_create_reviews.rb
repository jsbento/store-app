class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :author
      t.text :body
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
