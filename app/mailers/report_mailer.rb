require 'csv'

class ReportMailer < ApplicationMailer
  default from: 'ledger@ledger.com'
  
  def report_email

    @people = Person.where(active: true).includes([:user])
    @path = "tmp/people_report.csv"

    CSV.open(@path, "wb") do |csv|
      csv << %w{Name Documento Telefone Cadastrado Responsável Ativo Saldo}

      @people.each do |person|
        csv << [
          person.name,
          person.national_id,
          person.phone_number,
          person.created_at,
          person.user.email,
          person.active,
          person.balance,
        ]
      end
    end

    @user = params[:user]
    @shipment = params[:shipment]
    attachments['people_report.csv'] = File.read(@path)

    mail(to: @user.email, subject: "Your report is here!")
  end
end
