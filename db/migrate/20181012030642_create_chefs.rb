class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :username
    end
  end
end
