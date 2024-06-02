class MailerJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    ReportMailer.with(user: args.fetch(:user)).report_email.deliver_now
  end
end
