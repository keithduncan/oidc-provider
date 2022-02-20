module Oidc
  class ApplicationController < ActionController::Base

    def root
      render json: {}
    end

    def configuration
      render json: {
        issuer: root_url,
        jwks_uri: keyset_url,
        authorization_endpoint: "urn:kubernetes:programmatic_authorization",
        response_types_supported: ["id_token"],
        subject_types_supported: ["public"],
        claims_supported: ["sub", "iss"],
        id_token_signing_alg_values_supported: ["RS256"],
      }
    end

    def keyset
      keyset = instance_eval(&Oidc.keyset_lookup)
      if keyset.nil?
        render json: { keys: [] }
        return
      end

      render json: keyset.to_jwks
    end

  end
end
