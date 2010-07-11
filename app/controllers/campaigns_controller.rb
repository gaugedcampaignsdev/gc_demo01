class CampaignsController < ApplicationController
  require_role "admin", :for_all_except => [:show, :index]
  
  def index
    if current_user
      
      if current_user.has_role?('admin')
        @campaigns = Campaign.find(:all, :conditions => ['admin_id = ?', current_user.id])
      elsif current_user.has_role?('super')
        @campaigns = Campaign.find(:all)
      elsif current_user.has_role?('agent')
        @campaign_ids = Dialable.find(:all, :select => 'campaign_id', :conditions => ['user_id =?',current_user.id]).map(&:campaign_id)
        @campaigns = Campaign.find(:all, :conditions => ['id IN (?)', @campaign_ids])
      else
        @campaigns = Campaign.valid_campaigns
      end
    else
      @campaigns = Campaign.valid_campaigns
    end
  end
  
  def show
    @campaign = Campaign.find(:first, :conditions => ['title = ?', params[:title]])
    @donations = Donation.find(:all, :conditions => ['campaign_id=?', @campaign.id]).paginate :page => params[:page], :per_page  => 10
    if @donations
      @level = Donation.sum('donation', :conditions => ['campaign_id=?', @campaign.id])
      if @level == 0 
        @pxstat = 0
      else
        @pxstat = (@level/@campaign.target_amount) * 100
        if @pxstat >= 100
          @pxstat = 100
        end
      end
    else
      @pxstat = 0
      @level = 0
    end
    respond_to do |wants|
      wants.html
      wants.csv do
        @donations = Donation.find(:all, :conditions => ['campaign_id=?', @campaign.id])
        csv_string = FasterCSV.generate do |csv|
          # header row
          csv << ["First Name", "Last Name", "Donation", "Date/Time", 
                  "Credit Card", "Name", "Credit Card No.", "Card Expiration",
                  "Business", "Address", "City", "State", "Zip Code", "Phone Number", "Note"]

          # data rows
          @donations.each do |donation|
            csv << [donation.account.donor.first_name, 
              donation.account.donor.last_name,
              donation.donation,
              donation.created_at,
              donation.account.card_type,
              donation.account.name,
              "'" + donation.account.creditcard_no + "'",
              donation.account.expiration,
              donation.account.donor.business,
              donation.account.donor.address,
              donation.account.donor.city,
              donation.account.donor.state,
              donation.account.donor.zip_code,
              donation.account.donor.phone,
              donation.note ]
          end
        end

        # send it to the browser
        send_data csv_string,
                  :type => 'text/csv; charset=iso-8859-1; header=present',
                  :disposition => "attachment; filename=donation_report#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
      end
    end
  end
  
  def list_agents
    @campaign = Campaign.find(params[:campaign_id])
    @agents = User.find(:all, :conditions => ['is_agent = ?', true])
  end
  
  def add_agents
    
    params[:agent_ids].each do |agents|
      @dialable = Dialable.new
      @dialable.user_id = agents
      @dialable.campaign_id = params[:campaign_id]
      @dialable.save
    end
    redirect_to :action => 'list_agents', :campaign_id => params[:campaign_id]
  end
  
  def new
    @campaign = Campaign.new
  end
  
  def create
    @campaign = Campaign.new(params[:campaign])
    @campaign.campaign_status_id = params[:campaign_status_id]
    @campaign.deleted = false
    @campaign.admin_id = current_user.id
    if @campaign.save
      flash[:notice] = "Successfully created campaign."
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @campaign = Campaign.find(params[:id])
  end
  
  def update
    @campaign = Campaign.find(params[:id])
    @campaign.campaign_status_id = params[:campaign_status_id]
    if @campaign.update_attributes(params[:campaign])
      flash[:notice] = "Successfully updated campaign."
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @campaign = Campaign.find(params[:id])
    # delete all donations
    @campaign.deleted = true
    @campaign.save
    flash[:notice] = "Campaign tagged deleted."
    redirect_to campaigns_url
  end

end
