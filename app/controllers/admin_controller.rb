class AdminController < ApplicationController
  before_action :authenticate_user! 
  before_filter :set_user, :only => [:make_admin] 
  
  def index
  	if current_user.admin?
      @unmatched = Donation.unmatched
  		@organizations = Organization.last(5)
	  	@users = User.last(5)
	  	@donations = Donation.last(5)
  	end
  end

  def organizations
  	if current_user.admin?
  		@organization = Organization.all
  	end
  end

  def donations
  	if current_user.admin?
  	@donations = Donation.all
  	end
  end

  def users
  	if current_user.admin?
  		@users = User.all
  	end
  end
  
  def make_admin
  	if current_user.admin?
  		@target_user.admin = true
  		@target_user.save!
  		redirect_to admin_path
  	end
  end
  
  def confirm_match
    if not params[:organization_id] and not params[:donation_id].nil?
      @donation = Donation.find(params[:donation_id])
      @donation.recipient = Organization.find(params[:organization_id])
      @donation.save!
      flash[:notice] = "Donation match with success."
      flash[:notice_class] = "alert-success"
    else
      flash[:notice] = "Error! Can't process the match."
      flash[:notice_class] = "alert-danger"
    end
    redirect_to admin_path
  end
  def match
    @donation = Donation.find(params[:donation_id])
    @organizations = Organization.all # .accepting_donations
  end

  private 
  	def set_user
  		@target_user = User.find(params[:id])
  	end

end
