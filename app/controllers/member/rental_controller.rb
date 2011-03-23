# coding: utf-8

class Member::RentalController < Member::ApplicationController
  
  before_filter :login_required
  
  #before_filter :login_from_cookie
  
  def index
    #redirect_to login_path unless logged_in?
    @magazine_subscriptions = MagazineSubscription.find(:all)     
  end
  
  def return_rental_select_new_user
    begin
      @magazine_item = MagazineItem.find(params[:magazine_item_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Attempt to access invalid magazine_item #{params[:magazine_item_id]}"
      redirect_to :action => :index
    else
      @rental_queues = RentalQueue.find(:all, :conditions => 
        ["magazine_number_id = ?", @magazine_item.magazine_number.id ],
        :order => "created_at")
      
      # remove user not yet paid
      if Option.care_not_paid()
        @rental_queues.reject! do | rq |
          rq.user.paid != true
        end
      end
      
      # no more reader in rental queue. Add magazine admin if I am not a admin myself  
      if (@rental_queues.size == 0 && !current_user.magazine_admin?)
        Role.find_by_name('magazine_admin').users.each do |user|
          queue = RentalQueue.create(:user_id => user.id, :magazine_number_id => @magazine_item.magazine_number.id)
          queue.save
          @rental_queues << queue
        end
      end
      
      @rental_queues.sort! do |a,b| 
        "#{!a.user.paid} #{a.user.rentals.size} #{a.user.name}" <=> 
        "#{!b.user.paid} #{b.user.rentals.size} #{b.user.name}"
      end
    end
  end
  
  def return_rental_final
    if request.post?
      # return the rent
      begin
        @magazine_item = MagazineItem.find(params[:magazine_item_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Attempt to access invalid magazine_item #{params[:magazine_item_id]}"
        redirect_to :action => :index
      else
        # get the new user
        @new_user = User.find(params[:new_user_id])      
        if (@new_user)     
          current_user.return_magazine_item(@magazine_item)
          @new_user.rent_magazine_item(@magazine_item)
          @new_user.remove_rental_queue(@magazine_item.magazine_number)
       
          MagazineItemMailer.deliver_notify_new_user!(current_user, @new_user, @magazine_item)
          MagazineItemMailer.deliver_confirm_current_user!(current_user, @new_user, @magazine_item)       
        end
      end
    else
      redirect_to :action => :index
    end
  end
  
  def remove_rental_subscription
    if request.post?
      begin
        magazine_subscription = MagazineSubscription.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Attempt to access invalid magazine subscription #{params[:id]}"
      else
        current_user.remove_rental_subscription(magazine_subscription)
      end
      redirect_to :action => :index
    end
  end

  def remove_rental_queue
    if request.post?
      begin
        rental_queue = RentalQueue.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Attempt to access invalid rental queue #{params[:id]}"
      else
        rental_queue.destroy
      end     
      redirect_to :action => :index
    end
  end
  
  def add_rental
    flash[:notice] = "not implemented yet"
    redirect_to :action => :index
  end
  
  def add_rental_subscription
    if request.post?
      begin
        magazine_subscription = MagazineSubscription.find(params[:id])
      rescue
        flash[:error] = "Attempt to access invalid magazine subscription #{params[:id]}"
      else
        current_user.add_rental_subscription(magazine_subscription)
      end
      redirect_to :action => :index
    else
      @magazine_subscriptions = MagazineSubscription.find(:all)
      @magazine_subscriptions.reject! do | e |
        current_user.rental_subscription?(e)
      end
    end
  end
  
  def add_rental_queue
    if request.post?
      begin
        magazine_number = MagazineNumber.find(params[:id])
      rescue
        flash[:error] = "Attempt to access invalid magazine number #{params[:id]}"
      else
        current_user.add_rental_queue(magazine_number)
        
        # if the current_user if the first user how is on queue and the there are
        # renter out there, let notify them that a user is waiting for the magazine
        
        if (magazine_number.rental_queues().size == 1)
          magazine_number.magazine_items.each do | item |
            if (item.rental != nil)
              MagazineItemMailer.deliver_notify_first_user_added_to_queue!(item.rental.user,
               magazine_number)
            end
          end
        end
      end
      redirect_to :action => :index
    else
      @magazine_numbers = MagazineNumber.find(:all, 
        :order => "magazine_subscription_id, name")
      @magazine_numbers.reject! do | e |
        current_user.rent_magazine_number?(e) || 
        current_user.rental_queue?(e) || 
        !e.magazine_item_on_rent?
      end
    end
  end
  
  def add_new_magazine_number
    if request.post?
      @magazine_number = MagazineNumber.new
      @magazine_number.name = params[:name]
      @magazine_number.num_of_copy = params[:num_of_copy]
      @magazine_number.magazine_subscription = 
        MagazineSubscription.find_by_name(params[:magazine_subscription_name])
      if @magazine_number.save
        flash[:notice] = "Tidning nummer #{@magazine_number.full_name} är sparad"
        # add all items to the user rental
        @magazine_number.magazine_items.each do |item|
          current_user.rent_magazine_item(item)
      end
        
      # send email nofification if needed
      if (params[:email_notification] != nil)
        if (@magazine_number.magazine_subscription.rental_subscriptions.size > 0)
          MagazineItemMailer.deliver_notify_new_magazine_number!(@magazine_number)
          flash[:notice] = flash[:notice] + ". En epost har skickat till abonnerad läsarna."
        end
      end
      
      # auto add rental queue to all users
      if (params[:auto_add_rental_queue] != nil)
        rental_subscriptions = @magazine_number.magazine_subscription.rental_subscriptions
        
        # let the user with less rental history come first. See return_rental_select_new_user method
        rental_subscriptions.sort! do  |a,b|
          a.user.rental_histories.size <=> b.user.rental_histories.size
        end
        
        rental_subscriptions.each do |rs|
          rs.user.add_rental_queue(@magazine_number) if rs.user != current_user
        end
      end
      
        redirect_to :action => :index
      else
        flash[:error] = "Tidning nummer #{@magazine_number.name} kan inte spara"
      end
    else
      @magazine_number = MagazineNumber.new
    end
    @magazine_subscription_names = []
      MagazineSubscription.find(:all).each {|s| @magazine_subscription_names << s.name}
  end
  
  def show_rentals
    sort_by = params[:sort_by] || "rent_on"
    @rentals = Rental.find(:all)	
    
    # remove all rental which is belong to the magazine_admin
    @rentals.reject! do |r|
      r.user.magazine_admin?  
    end
    
    @rentals.sort! do |a,b|
      case sort_by
      when "name" then a.user.name <=> b.user.name
      when "magazine" then a.magazine_item.full_name <=> b.magazine_item.full_name
      else
        a.rent_on <=> b.rent_on
      end
    end
  end
  
  def show_magazines
    @magazines = MagazineNumber.find(:all)
    @magazines.reject! do | m | 
      m.rental_queues.size == 0
    end
    @magazines.sort! do |a,b|
      a.full_name <=> b.full_name
    end
  end
  
  def show_user_rentals
    sort_by = params[:sort_by] || "rental"
    
    @users = User.find(:all)
    
    # gäller inte magazine_admin
    @users.reject! do |u|
      u.magazine_admin?
    end
    
    @users.sort! do |a,b|
      case sort_by
      when "name" then b.name <=> a.name 
      when "rental_history" then a.rental_histories.size <=> b.rental_histories.size
      else
        b.rentals.size <=> a.rentals.size
      end
    end
  end
  
  def show_rental_histories
    sort_by = params[:sort_by] || "return_on"
    @rental_histories = RentalHistory.find(:all)
    
    # remove all rental which is belong to the magazine_admin
    @rental_histories.reject! do |r|
      r.user.magazine_admin?  
    end
    
    @rental_histories.sort! do |a,b|
      case sort_by
      when "user" then a.user.name <=> b.user.name
      when "return_on" then b.return_on <=> a.return_on
      when "num_day" then (b.return_on - b.rent_on) <=> (a.return_on - a.rent_on)
      else
        "#{a.magazine_item.full_name} #{a.rent_on}" <=> "#{b.magazine_item.full_name} #{b.rent_on}"
      end      
    end
  end 

  def show_magazine_subscriptions
    @magazine_subscriptions = MagazineSubscription.find(:all)     
    @magazine_subscriptions.sort! do |a,b|
      a.name <=> b.name
    end
  end

  def remove_rental
    if request.post?
      begin
        rental = Rental.find(params[:rental_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Attempt to access invalid rental #{params[:rental_id]}"
      else
        rental.destroy
        flash[:notice] = "Rental is removed"
        redirect_to :action => :show_rentals
      end
    end
  end
  
  def send_rental_remind
    if request.post?
      begin
        rental = Rental.find(params[:rental_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Attempt to access invalid rental #{params[:rental_id]}"
      else
        MagazineItemMailer.deliver_notify_rental_remind!(current_user,rental)
        
        flash[:notice] = "Rental reminder is sent"
        redirect_to :action => :show_rentals
      end
    end
  end
end
