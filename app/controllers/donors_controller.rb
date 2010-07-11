class DonorsController < ApplicationController
  def index
    @donors = Donor.find(:all)
  end
  
  def show
    @donor = Donor.find(params[:id])
    
    respond_to do |format|
     format.html
     format.js { render_to_facebox }
    end
  end
  
  def new
    @donor = Donor.new
    @account = Account.new
    @donation = Donation.new
    @campaign = Campaign.find(:first, :conditions => ['title =?', params[:title]])
  end
  
  def lookup_info (use_subdomain)
    @donor = Donor.new
    @account = Account.new
    @donation = Donation.new
    @campaign = Campaign.find_by_subdomain(use_subdomain)
  end
  
  def create
    @donor = Donor.new(params[:donor])
    @donor.campaign_id = params[:donation][:campaign_id]
    @campaign = Campaign.find(:first, :conditions => ['id = ?', params[:donation][:campaign_id]])
    if @donor.save!
      @account = Account.new(params[:account])
      @account.donor_id = @donor.id
      if @account.save!
        if params[:donation][:donation] == "OTHERS"
          params[:donation][:donation] = params[:donation_amt]
        end
        @donation = Donation.new(params[:donation])
        @donation.account_id = @account.id
        @donation.save
      end
      flash[:notice] = "Donation details successfully saved."
    end    
    redirect_to view_campaign_path(@campaign.title)
    
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "There was a problem creating your donation. Verify the required fields."
      redirect_to :action => 'new', :campaign_id => params[:donation][:campaign_id]

  end
  
  def edit
    @donor = Donor.find(params[:id])
    @campaign = Campaign.find(@donor.campaign_id)
    @account = Account.find_by_donor_id(@donor.id)
    @donation = Donation.find(:first, :conditions => ['account_id=? and campaign_id=?', @account.id, @campaign.id])
  end
  
  def update
    @donor = Donor.find(params[:id])
    if @donor.update_attributes(params[:donor])
      @account = Account.find_by_donor_id(@donor.id)
      @account.update_attributes(params[:account])
      @campaign = Campaign.find(@donor.campaign_id)
      if params[:donation][:donation] == "OTHERS"
        params[:donation][:donation] = params[:donation_amt]
      end
      @donation = Donation.find(:first, :conditions => ['account_id=? and campaign_id=?', @account.id, @campaign.id])
      @donation.update_attributes(params[:donation])
      flash[:notice] = "Successfully updated donation information."
      redirect_to view_campaign_path(@campaign.title)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @donor = Donor.find(params[:id])
    @campaign = Campaign.find(@donor.campaign_id)
    @account = Account.find_by_donor_id(@donor.id)
    @donation = Donation.find(:first, :conditions => ['account_id=? and campaign_id=?', @account.id, @campaign.id])
    
    @donor.destroy
    @account.destroy
    @donation.destroy
    
    flash[:notice] = "Donation entry deleted."
    redirect_to view_campaign_path(@campaign.title)
  end
end