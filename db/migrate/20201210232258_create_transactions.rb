class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_categories do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :transactions do |t|
      t.text :note, null: true
      t.decimal :amount, null: false, precision: 13, scale: 2
      t.datetime :transaction_date, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :transaction_category, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
