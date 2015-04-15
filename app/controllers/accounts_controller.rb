class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    # @accounts = Account.order(:buyday).all.page(params[:page]).per(5)
    @accounts = Account.all.page(params[:page]).per(5)
    @grouped_months = @accounts.group_by { |r| r.buyday.beginning_of_month}

    @month_num = ['1','2','3','4','5','6','7','8','9','10','11','12']
    @month_details = []
    @month_costs = []
     (0..11).each do |i|
       @month_details[i] = Account.where(["date_part('month',buyday) = ? and date_part('year',buyday) = ?" , @month_num[i],2015]).order('buyday desc')
       @month_costs[i] = Account.where(["date_part('month',buyday) = ? and date_part('year',buyday) = ?" , @month_num[i],2015]).sum(:dollar)
     end
    # @mar = Account.where(['buyday between ? and ?', '2015-03-01', '2015-03-31' ])
    
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:buyday, :title, :dollar, :description)
    end
end
