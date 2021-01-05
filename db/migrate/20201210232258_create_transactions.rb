class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.decimal :total_amount, null: false, precision: 13, scale: 2, default: 0.00
      t.datetime :report_date, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :month # make validation in report model like: validates :rating, :inclusion => { :in => 0..100 } https://stackoverflow.com/questions/27370251/activerecord-adding-rating-range-in-migration-file
      t.integer :year
      
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps null: false
    end

    add_index :reports, [:user_id, :month, :year]
    
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
      t.belongs_to :report, null: false, foreign_key: true

      t.timestamps null: false
    end

    create_table :budgets do |t|
      t.decimal :amount, null: false, precision: 13, scale: 2
      t.boolean :active
      
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :report, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
