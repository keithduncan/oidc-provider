require 'aws-sdk-kms'

module Oidc
  class Key
    class Kms < Key
      def sign(id_token)
        # private_key is an AWS KMS key ARN
        # e.g. arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab
        id_token.kid = OpenSSL::PKey::RSA.new(public_key).to_jwk.thumbprint
        id_token.sign(Shim.new(arn: private_key), :RS256)
      end

      private

      class Shim
        def initialize(arn:)
          @arn = arn
        end

        def sign(digest, data)
          region = @arn.split(":")[3]

          client = Aws::KMS::Client.new(
            region: region,
          )

          message = digest.digest(data)

          resp = client.sign(
            key_id: @arn,
            message: message,
            message_type: 'DIGEST',
            signing_algorithm: 'RSASSA_PKCS1_V1_5_SHA_256'
          )

          resp['signature']
        end
      end
    end
  end
end
