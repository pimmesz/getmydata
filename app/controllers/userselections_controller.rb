class UserselectionsController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:select, :create, :destroy]
  # before_action :authenticate_user!

  def select
    @user_selection = UserSelection.new
    @user_selections = UserSelection.all

    @contacted_companies = []
    if current_user.present?
      current_user.messages.each do |company|
        @contacted_companies << Company.find(company.company_id)
      end
    end

    @companies = Company.where("approved = true")

    @unique_categories = @companies.map(&:category).uniq

    # Needs to be companies instead of selection to be able to compare directly with companies
    @selected_companies = @user_selections.map(&:company)

    # Comparing all companies with the currently selected companies

    @unselected_companies = @companies - @selected_companies - @contacted_companies

    policy_scope(Company)

    @companies = params[:query].present? ?
    Company.search_by_name_and_category(params[:query].capitalize) - Company.where("approved = false") :
    # Company.all
    Company.where("approved = true")
    @companies = @companies - @selected_companies - @contacted_companies

    if @companies.blank?
      skip_authorization
    else
      @companies.each { |company| authorize company }
    end

    respond_to do |format|
      format.html { render 'userselections/select'}
      format.js
    end

  end

  def new
    authorize current_user
    policy_scope(UserSelection)

    @user_selection = UserSelection.new

    user_signed_in? ? @user_selection.user_id = current_user.id : @user_selection.user_id = session[:guest_user_id]
    @user_selection.company_id = params["user_selection"]["company_id"].to_i
    @user_selection.save
  end

  def create
    # Create new user selection
    @companies = Company.where("approved = true")
    # @companies = Company.all
    @user_selection = UserSelection.new(user_selection_params)
    user_signed_in? ? @user_selection.user_id = current_user.id : @user_selection.user_id = session[:guest_user_id]

    @selection_array = []
    user_signed_in? ? user_selections = UserSelection.where(user_id: current_user.id) : user_selections = UserSelection.where(user_id: session[:guest_user_id])

    if @user_selections.present?
      @selected_companies = @user_selections.map(&:company)
      @unselected_companies = @companies - @selected_companies
    end

    authorize @user_selection
    if @user_selection.save
      respond_to do |format|
        format.html { redirect_to select_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'userselections/select'}
        format.js
      end
    end
  end

  def destroy
    @user_selection = UserSelection.find(params[:id])
    @user_selection.destroy
    authorize @user_selection
    policy_scope(UserSelection)
  end

  protected

  def user_selection_params
    params.require(:user_selection).permit(:company_id)
  end
end
