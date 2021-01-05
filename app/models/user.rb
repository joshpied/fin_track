class User < ApplicationRecord
  include Clearance::User

  has_many :transactions
  has_many :reports
  has_many :budgets
end
