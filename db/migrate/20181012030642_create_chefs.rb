class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :username
      t.string :password_digest
      t.string :email
    end
  end
end
