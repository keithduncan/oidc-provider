class TokensController < ApplicationController
  before_action :load_organization

  def show
    @token = Rails.application.keyset.issue_id_token(
      issuer: oidc_url,
      audience: "sts.amazonaws.com",
      subject: "my-service:org:#{@organization.slug}:resource:#{'baz'}",
      valid_for: 1.hour,
    ).to_s
  end

  private

  def load_organization
    @organization = Organization.find_by!(slug: params[:organization_id])
  end
end
