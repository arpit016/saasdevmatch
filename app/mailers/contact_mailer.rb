class ContactMailer < ActionMailer::Base
    default to: 'agarwalarpit22@gmail.com'
    
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        
        mail(from: email, subject: 'Contact Message Form')
    end
end