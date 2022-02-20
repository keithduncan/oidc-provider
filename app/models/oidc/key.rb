require "json/jwt"

module Oidc
  class Key < ApplicationRecord
    belongs_to :keyset

    def public_jwk
      key = OpenSSL::PKey::RSA.new(public_key || private_key)
      key.public_key.to_jwk
    end
  end
end
