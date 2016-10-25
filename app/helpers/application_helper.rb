module ApplicationHelper

	def my_organization
		if user_signed_in? and not current_user.organization.nil?
			return link_to "My Organization", organization_path(id: current_user.organization), class: "nav-item nav-link"
		else
			return link_to "New Organization", new_organization_path, class: "nav-item nav-link"
		end	
	end

	def user_options
		html = "<li class='nav-item'>"
		if user_signed_in?
			html += link_to "Log Out", destroy_user_session_path, :method => :delete
		else 
			html += link_to "Sign In", new_user_session 
			html += link_to "Sign Up", new_user_registration 
		end
		html += "</li>"
		return html
	end

	def render_status(donation)
		html = "<span class='"
		if donation.on_hold?
			html += "btn-sm outline-onhold'>On Hold</span>"
		elsif donation.confirmed?
			html += "btn-sm outline-confirmed'>Confirmed</span>"
		elsif donation.canceled?
			html += "btn-sm outline-canceled'>Canceled</span>"
		else
			html += donation.status
			html += "</span>"
		end
	end

	def render_donation_actions(donation)	
		html = link_to "Foods", donation_foods_path(donation), class: "btn btn-sm btn-info"
		if donation.on_hold?
			html += link_to icon('pencil-square-o')+" Edit", edit_donation_path(donation), class: "btn btn-sm btn-warning"
    elsif donation.confirmed?
    	html += link_to "Hold Donation", donation_status_update_path(donation, :status => "On Hold"), class: "btn btn-sm btn-warning", confirm: "Are you sure?"
    end
    
    html += link_to icon('times')+" Cancel", donation_status_update_path(donation, :status => "Canceled"), class: "btn btn-sm btn-danger", confirm: "Are you sure?"
	end

	def render_food_actions(donation, food)	
    html = link_to icon('times')+" Delete", donation_food_path(donation, food), class: "btn btn-sm btn-danger", confirm: "Are you sure?"
	end

	def render_donator(donation)
		if donation.anonymous
			return "Anonymous"
		else
			if donation.personal
				return donation.user.name
			else
				return donation.organization.name
			end	
		end
	end

	def render_time(datetime)
		return "" if datetime.nil?
		return datetime.to_formatted_s(:short)
	end

end
