class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :parse_datetime, :only => [:create, :update]
  load_and_authorize_resource
  

  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.by_person(current_user.id) || []
  end
  
  # GET /donations/1
  # GET /donations/1.json
  def show
  end

  # GET /donations/new
  def new
    @donation = Donation.new
  end

  # GET /donations/1/edit
  def edit
  end

  # POST /donations
  # POST /donations.json
  def create

    @donation = Donation.new(donation_params)
    @donation.user = current_user
    if not current_user.organization.nil?
      @donation.organization = current_user.organization
    end
    @donation.on_hold!

    respond_to do |format|
      if @donation.save
        format.html { 
          flash[:notice] = 'Donation was successfully created.'
          flash[:notice_class] = "alert-success"
          redirect_to donation_foods_path(@donation) }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { 
          flash[:notice] = 'Donation could not be created.'
          flash[:notice_class] = "alert-danger"
          render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { 
          flash[:notice] = 'Donation was successfully updated.'
          flash[:notice_class] = "alert-success"
          redirect_to @donation }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { 
          flash[:notice] = 'Donation could not be updated.'
          flash[:notice_class] = "alert-danger"
          render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { 
          flash[:notice] = 'Donation was deleted.'
          flash[:notice_class] = "alert-success"
          redirect_to donations_url }
      format.json { head :no_content }
    end
  end

  def status_update
    @donation = Donation.find(params[:donation_id])
    if params[:status].nil?
      flash[:notice] = 'ERROR!.'
      flash[:notice_class] = "alert-danger"
      render :back
    elsif params[:status].eql?('Confirmed')
      @donation.confirmed!
      flash[:notice] = 'Donation is confirmed.'
      flash[:notice_class] = "alert-success"
      redirect_to donations_url
    elsif params[:status].eql?('On Hold')
      @donation.on_hold!
      flash[:notice] = 'Donation is On Hold.'
      flash[:notice_class] = "alert-success"
      redirect_to donations_url
    elsif params[:status].eql?('Canceled')
      @donation.canceled!
      flash[:notice] = 'Donation was canceled.'
      flash[:notice_class] = "alert-success"
      redirect_to donations_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
      if not @donation.user.eql?(current_user)
        flash[:notice] = "Sorry, your access was denied!"
        redirect_to root_url 
      end
    end

    def parse_datetime
      params[:donation][:pickup_window_start] = DateTime.strptime(donation_params[:pickup_window_start],'%m/%d/%Y %I:%M %p')
      params[:donation][:pickup_window_end] = DateTime.strptime(donation_params[:pickup_window_end],'%m/%d/%Y %I:%M %p')
    end  


    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:pickup_window_start, :pickup_window_end, :comments, :anonymous, :vehicle, :pickup_address, :personal)
    end
end
