module Oidc
  class Key
    class Db < Key
      def sign(id_token)
        # private_key is a PEM encoded RSA private key
        id_token.kid = OpenSSL::PKey::RSA.new(public_key).to_jwk.thumbprint
        id_token.sign(OpenSSL::PKey::RSA.new(private_key), :RS256)
      end
    end
  end
end