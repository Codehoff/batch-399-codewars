class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :rank
      t.integer :score
      t.integer :honor

      t.timestamps
    end
  end
end
