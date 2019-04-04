class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login
      t.integer :gh_id
      t.string :type
      t.string :name
      t.string :company
      t.string :blog
      t.string :location
      t.string :email
      t.boolean :hireable
      t.text :bio
      t.integer :public_repos
      t.integer :public_gists
      t.integer :followers
      t.integer :following

      t.timestamps
    end
  end
end
