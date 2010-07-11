class CompaniesController < ApplicationController
  def index
    if current_user.has_role?('admin')
      @companies = Company.find(:all, :conditions => ['user_id = ?', current_user.id])
    elsif current_user.has_role?('super')
      @companies = Company.find(:all)
    end
  end
  
  def show
    @company = Company.find(params[:id])
  end
  
  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:notice] = "Successfully created company."
      redirect_to @company
    else
      render :action => 'new'
    end
  end
  
  def edit
    @company = Company.find(params[:id])
  end
  
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Successfully updated company."
      redirect_to @company
    else
      if current_user.has_role?('super')
        redirect_to companies_url
      else
        redirect_to @company
      end
    end
  end
  
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = "Successfully destroyed company."
    redirect_to companies_url
  end
end