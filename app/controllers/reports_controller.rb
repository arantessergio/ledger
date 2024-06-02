class ReportsController < ApplicationController
  def balance
    # ReportMailer.with(user: current_user).report_email.deliver_now
    MailerJob.perform_now({ user: current_user })
  end
end
