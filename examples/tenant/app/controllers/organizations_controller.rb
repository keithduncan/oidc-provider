class OrganizationsController < ApplicationController

	def show
		@organization = Organization.find_by(slug: params[:id])
	end

end
