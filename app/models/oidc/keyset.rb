require "json/jwt"

module Oidc
  class Keyset < ApplicationRecord
    has_many :keys

    def to_jwks
      JSON::JWK::Set.new(keys.map(&:public_jwk))
    end

    def issue_id_token(issuer:, audience:, subject:, valid_for:)
      now = Time.now
      
      claims = {
        iss: issuer,
        sub: subject,
        aud: audience,
        iat: now,
        exp: now + valid_for,
        nonce: SecureRandom.hex(16),
      }
      id_token = JSON::JWT.new(claims)

      signing_key.sign(id_token)
    end

    def decode_id_token(token)
      JSON::JWT.decode(token, to_jwks)
    end

    private

    def signing_key
      keys.last
    end
  end
end
