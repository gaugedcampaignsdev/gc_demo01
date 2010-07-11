class UsersController < ApplicationController

  def new
    @user = User.new
    @company = Company.new
  end

  def new_agent
    @user = User.new
  end

 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    if params[:company]
      @company = Company.new(params[:company])
      @user.company_id = @company.id
      @user.is_company_admin = true
      if !@company.save
        @company_with_error = true
      end
    end
    
    if @company_with_error
      flash[:error]  = "There was an error creating your account."
      render :action => 'new'
    else
      success = @user && @user.save
      if success && @user.errors.empty?
        @user.activate! #activate new user
        
        if params[:company]
          @company.user_id = @user.id
          @company.status = 1 #tag as to be verified
          @company.save
        end
        redirect_to root_url
        flash[:notice] = "Thanks for signing up!"
      else
        flash[:error]  = "There was an error creating your account."
        render :action => 'new'
      end
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated..."
    else
      flash[:error] = "Update failed"
    end
    redirect_to user_dashboard_path
  end
  
  def user_list
    if current_user.has_role?('admin')
      @users = User.find(:all, :conditions => ['id <> ? AND id <> 1', current_user.id])
    else
      @users = User.all
    end
    @roles = Role.all
  end
  
  def edit_user_role
    @user = User.find(params[:id])
    if current_user.has_role?('super')
      @roles = Role.all
    elsif current_user.has_role?('admin')
      @roles = Role.find(:all, :conditions => ['name != "super"'])
    end
  end
  
  def update_user_role
    @user = User.find(params[:user][:id])
    @role = Role.find(params[:user][:role_ids])
    if @role.name == "agent"
      @user.is_agent = true
    end
    @user.update_attributes(params[:user])
    redirect_to user_list_path
  end
  
  # action to perform when the user wants to change their password
  def change_password
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      current_user.password_confirmation = params[:password_confirmation]
      current_user.password = params[:password]
      if current_user.save!
        flash[:notice] = "Password updated successfully"
        if current_user.has_role?('user')
          redirect_to user_dashboard_path
        elsif current_user.has_role?('admin')
          redirect_to admin_dashboard_path
        elsif current_user.has_role?('agent')
          redirect_to agent_dashboard_path
        end
      else
        flash[:alert] = "Password not changed"
      end
    else
      flash[:alert] = "Old password incorrect"
    end
  end
  
end