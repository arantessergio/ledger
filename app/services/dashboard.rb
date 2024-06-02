class Dashboard
  def initialize(active_people_ids, current_user)
    @active_people_ids = active_people_ids
    @current_user = current_user
  end
  def balance(total_payments, total_debts)
    total_payments - total_debts
  end
  def total_debts
    Debt.where(person_id: @active_people_ids).sum(:amount)
  end
  def total_payments
    Payment.where(person_id: @active_people_ids).sum(:amount)
  end
  def last_debts
    Debt.order(created_at: :desc).limit(10).map do |debt|
      [debt.id, debt.amount]
    end
  end
  def last_payments
    Payment.order(created_at: :desc).limit(10).map do |payment|
      [payment.id, payment.amount]
    end
  end
  def me
    Person.where(user: @current_user).order(:created_at).limit(10)
  end
  def top_person
    Person.order(:balance).last
  end
  def bottom_person
    Person.order(:balance).first
  end
end
