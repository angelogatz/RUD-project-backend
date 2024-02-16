class CreateAnnotations < ActiveRecord::Migration[7.1]
  def change
    create_table :annotations do |t|
      t.string :title
      t.string :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
