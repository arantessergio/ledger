class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_people_pie_chart = {
      active: Person.where(active: true).count,
      inactive: Person.where(active: false).count
    }

    active_people_ids = Person.where(active: true).select(:id)
    
    @service = Dashboard.new(active_people_ids, current_user)
    @total_debts = @service.total_debts
    @total_payments = @service.total_payments
    @balance = @service.balance(@total_payments, @total_debts)
    @last_debts = @service.last_debts
    @last_payments = @service.last_payments
    @my_people = @service.me
    @top_person = @service.top_person
    @bottom_person = @service.bottom_person
  end
end
