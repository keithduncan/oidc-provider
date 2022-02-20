class TokensController < ApplicationController
  before_action :load_organization
  before_action :load_cluster

  def show
    @token = @cluster.keyset.issue_id_token(
      issuer: organization_cluster_oidc_url(@organization),
      audience: "sts.amazonaws.com",
      subject: "my-service:org:#{@organization.slug}:cluster:#{@cluster.name}:resource:#{'baz'}",
      valid_for: 1.hour,
    ).to_s
  end

  private

  def load_organization
    @organization = Organization.find_by!(slug: params[:organization_id])
  end

  def load_cluster
    @cluster = @organization.clusters.find_by!(name: params[:cluster_id])
  end
end
