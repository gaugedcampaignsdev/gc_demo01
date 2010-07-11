# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def required_field_mark
    return "<span style='color:red;'>*</span>"
  end
  
  def title(arg)
    return "<h3 style='color:#8F0000'>#{arg}</h3>"
  end
  
  def real_currency(arg)
    return number_to_currency(arg, :unit => '$', :separator => ".", :delimeter => "," )
  end
  
  def card_type
     return card_type = ["MasterCard", "Visa", "Discover", "AMEX"]
   end

  def donation
   return donation = [150, 300, 7500, 1500]
  end
  
  def company_status
    return company_status = {"Pending" => 1, "Approved" => 2, "Suspended" => 3}
  end

 def donation_accounts
	donation_inc = Array.new
	19.times do |x|
		donation_inc << (x+1) * BASE_INC
	end

	return donation_inc
 end
end