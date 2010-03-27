class MagazineItemMailer < ActionMailer::Base

  def notify_new_user(current_user, new_user, magazine_item)
    subject "#{Option.get("Section")} - ny tidning på väg.."
    body :current_user => current_user, :new_user => new_user, 
         :magazine_item => magazine_item
    recipients new_user.email
    from       Option.get("Email")
    sent_on    Time.now
  end
  
  def confirm_current_user(current_user, new_user, magazine_item)
    subject "#{Option.get("Section")} - bekräftelse"
    body :current_user => current_user, :new_user => new_user, 
         :magazine_item => magazine_item
    recipients current_user.email
    from       Option.get("Email")
    sent_on    Time.now
  end
  
  def notify_first_user_added_to_queue(user, magazine_number)
  	subject "#{Option.get("Section")} - ny läsare vänta på din tidning"
    body :user => user, :magazine_number => magazine_number
    recipients user.email
    from       Option.get("Email")
    sent_on    Time.now
  end
  
  def notify_new_magazine_number(magazine_number)
  	subject "#{Option.get("Section")} - en ny tidning"
    body :magazine_number => magazine_number
    from       Option.get("Email")
    sent_on    Time.now
    
    users = []
    magazine_number.magazine_subscription.rental_subscriptions.each do |rs|
    	users << rs.user.email
    end
    recipients users
  end
  
  def send_login_info(user)
    subject "#{Option.get("Section")} - inloggningsuppgift"
    body :user => user
    from       Option.get("Email")
    sent_on    Time.now
    recipients user.email
  end
  
  def notify_rental_remind(current_user, rental)
    subject "#{Option.get("Section")} - Påminnelse #{rental.magazine_item.full_name}"
    body :rental => rental
    from       current_user.email
    sent_on    Time.now
    recipients rental.user.email
    
    rental.last_remind_date = Date.today
    rental.save
  end
  
   def notify_received_payment(current_user, user)
    subject "#{Option.get("Section")} - Medlemsavgift är betalt"
    body :user => user
    from       current_user.email
    sent_on    Time.now
    recipients user.email  
  end
end
