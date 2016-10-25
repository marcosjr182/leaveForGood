class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: [:show, :edit, :update, :destroy]
  before_action :set_donation
  load_and_authorize_resource

  # GET /foods
  # GET /foods.json
  def index
    @food = Food.new
    @foods = @donation.foods

  end

  # GET /foods/1
  # GET /foods/1.json
  def show
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  # POST /foods.json
  def create
    @food = Food.new(food_params)
    @food.donation = @donation

    respond_to do |format|
      if @food.save
        format.html { flash[:notice] = 'Food was successfully added.'
                      flash[:notice_class] = 'alert-success'
                      redirect_to donation_foods_path(@food.donation_id)
                    }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  # PATCH/PUT /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    def set_donation
      @donation = Donation.find(params[:donation_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:name, :food_type, :qty, :donation_id)
    end
end
