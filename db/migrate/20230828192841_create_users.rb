class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :wallet_address
      t.boolean :has_required_nft
      t.string :avatar

      t.timestamps
    end
  end
end
