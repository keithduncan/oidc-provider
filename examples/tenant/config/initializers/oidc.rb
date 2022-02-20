Oidc.keyset_lookup = Proc.new {
	Organization.find_by(slug: params[:organization_id]).keyset
}
