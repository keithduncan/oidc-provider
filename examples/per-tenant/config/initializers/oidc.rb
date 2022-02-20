Oidc.keyset_lookup = Proc.new {
	Organization
		.find_by(slug: params[:organization_id])
		.clusters
		.find_by(name: params[:cluster_id])
		.keyset
}
