# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

exit if !Rails.env.development?

puts "Deleting the Data"
User.delete_all
TransactionCategory.delete_all
Transaction.delete_all

puts "Creating User"
user = User.create(email: "test@test.com", password: "testers")

puts "Creating Transaction Categories"
# todo: add a color (https://tailwindcss.com/docs/customizing-colors) and icon to each category
category_list = [
  "Travel",
  "Education",
  "Transport",
  "Home",
  "Sports/Fitness",
  "Hobbies",
  "Haircut/Beauty",
  "Car",
  "Gifts",
  "Shopping",
  "Personal",
  "Work",
  "Entertainment",
  "Groceries",
  "Food and Drink",
  "Bills and Fees",
  "Healthcare",
  "Other"
]

category_list.each do |category|
  TransactionCategory.create( name: category )
end

puts "Creating Transactions"
transaction1 = Transaction.create(note: "plane ticket", amount: 674.37, transaction_date: "2020-12-11 16:56:45.330148", transaction_category_id: 1, user: user)
transaction2 = Transaction.create(note: "bought calculator", amount: 26.50, transaction_date: "2020-12-12 16:56:45.330148", transaction_category_id: 2, user: user)
transaction3 = Transaction.create(note: "bus ticket", amount: 3.60, transaction_date: "2020-12-13 16:56:45.330148", transaction_category_id: 3, user: user)
transaction4 = Transaction.create(note: "peace lily", amount: 18.34, transaction_date: "2020-12-15 16:56:45.330148", transaction_category_id: 4, user: user)
