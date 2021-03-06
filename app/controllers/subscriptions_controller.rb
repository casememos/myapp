class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.json
  before_filter :user_is_admin_filter?, :except => [:new, :create, :show]
  before_filter :plan_id_present?, :only => [:new, :create]

  def index
    @subscriptions = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new 

    @subscription = Subscription.new
    @plan = Plan.where(:name => params[:name]).first
    if @plan
      @subscription.plan_id = @plan.id
    else
      @subscription.plan_id = Plan.first.id
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user_id = current_user.id
    @subscription.site_id = @site.id
    @subscription.status = 'Active'
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
     render :new
   end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end

  private

  def plan_id_present?
    return true if Plan.where(:name => params[:name]).present?
     redirect_to message_path, notice: 'Invalid plan name. Cannot create subscription'
  end
end
