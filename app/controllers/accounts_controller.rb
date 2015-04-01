class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.order(:buyday)
    @grouped_months = @accounts.group_by { |r| r.buyday.beginning_of_month}
    # @accounts = Account.order("buyday desc")
    # @total =  @accounts.sum(:dollar)
    # @grouped_months.keys.sort.each do |month|
    #   for account in @grouped_months[month]
    #     @total = account.dollar.to_s(:long).sum
    #     # Account.where('created_at >= ? and created_at <= ?', buyday.beginning_of_month, buyday.utc.end_of_month).sum('dollar')
    #   end 
    # end
    
    # date = DateTime.now.utc
    # @total = Account.where('created_at >= ? and created_at <= ?', date.beginning_of_month, date.utc.end_of_month).sum('dollar')
    
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
