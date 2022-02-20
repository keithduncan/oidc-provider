require_relative "lib/oidc/version"

Gem::Specification.new do |spec|
  spec.name        = "oidc"
  spec.version     = Oidc::VERSION
  spec.authors     = ["Keith Duncan"]
  spec.email       = ["keith_duncan@me.com"]
  spec.homepage    = "https://github.com/keithduncan/oidc-provider"
  spec.summary     = "OpenID Connect provider Rails engine with support for per-tenant keysets"
  spec.description = "Mount this engine in your routes for a per-tenant OIDC provider, e.g. /organization/:org_slug/oidc."
  spec.license     = "AGPL-3.0-only"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/keithduncan/oidc-provider/releases"

  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
  spec.add_dependency "json-jwt", "~> 1.13.0"
  spec.add_dependency "aws-sdk-kms", "~> 1.54"
end
