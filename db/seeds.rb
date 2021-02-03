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
Budget.delete_all
Report.delete_all

puts "Creating User"
user = User.create(email: "test@test.com", password: "testers") # update to add username too -> class UsersController < Clearance::UsersController

puts "Creating Reports"
# setting reports to $0 because after_create, after_update, and after_destroy methods 
# in transaction.rb model will take care of incrementing/decrementing report amounts
# november 2020
report1 = Report.create(total_amount: 0.00, report_date: "2020-11-01 00:00:00", month: 11, year: 2020, user_id: user.id)
# december 2020
report2 = Report.create(total_amount: 0.00, report_date: "2020-12-11 00:00:00", month: 12, year: 2020, user_id: user.id)
# january 2021
report3 = Report.create(total_amount: 0.00, report_date: "2021-01-01 00:00:00", month: 1, year: 2021, user_id: user.id)

puts "Creating Budgets"
# november budget
budget1 = Budget.create(amount: 5500, active: true, report: report1, user: user)
# december budget
budget2 = Budget.create(amount: 7000, active: true, report: report2, user: user)

puts "Creating Transaction Categories"
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
# november
transaction1 = Transaction.create(note: "bought a mazda", amount: 22000.00, transaction_date: "2020-11-01 00:00:00", transaction_category_id: 8, user: user, report: report1)
transaction2 = Transaction.create(note: "crackerjacks", amount: 3.55, transaction_date: "2020-11-18 00:00:00", transaction_category_id: 15, user: user, report: report1)
# december
transaction3 = Transaction.create(note: "plane ticket", amount: 674.37, transaction_date: "2020-12-11 00:00:00", transaction_category_id: 1, user: user, report: report2)
transaction4 = Transaction.create(note: "bought calculator", amount: 26.50, transaction_date: "2020-12-12 00:00:00", transaction_category_id: 2, user: user, report: report2)
transaction5 = Transaction.create(note: "bus ticket", amount: 3.60, transaction_date: "2020-12-13 00:00:00", transaction_category_id: 3, user: user, report: report2)
transaction6 = Transaction.create(note: "peace lily", amount: 18.34, transaction_date: "2020-12-15 00:00:00", transaction_category_id: 4, user: user, report: report2)
# january
transaction7 = Transaction.create(note: "toothbrush", amount: 505.55, transaction_date: "2021-01-02 00:00:00", transaction_category_id: 11, user: user, report: report3)
transaction8 = Transaction.create(note: "new windshield", amount: 71.22, transaction_date: "2021-01-03 00:00:00", transaction_category_id: 8, user: user, report: report3)
transaction9 = Transaction.create(note: "chickens", amount: 44.64, transaction_date: "2021-01-04 00:00:00", transaction_category_id: 14, user: user, report: report3)
transaction10 = Transaction.create(note: "misc items", amount: 1500.87, transaction_date: "2021-01-05 00:00:00", transaction_category_id: 18, user: user, report: report3)
transaction11 = Transaction.create(note: "plane tickets", amount: 880.64, transaction_date: "2021-01-06 00:00:00", transaction_category_id: 1, user: user, report: report3)
transaction12 = Transaction.create(note: "coca cola", amount: 5.56, transaction_date: "2021-01-07 00:00:00", transaction_category_id: 9, user: user, report: report3)
transaction13 = Transaction.create(note: "film", amount: 347.25, transaction_date: "2021-01-08 00:00:00", transaction_category_id: 13, user: user, report: report3)
transaction14 = Transaction.create(note: "massage", amount: 43.26, transaction_date: "2021-01-10 00:00:00", transaction_category_id: 7, user: user, report: report3)


