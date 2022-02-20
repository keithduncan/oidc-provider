class ClustersController < ApplicationController
	before_action :load_organization

	def show
		@cluster = @organization.clusters.find_by!(name: params[:id])
	end

	private

	def load_organization
		@organization = Organization.find_by!(slug: params[:organization_id])
	end

end
