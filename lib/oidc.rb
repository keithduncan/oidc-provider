require "oidc/version"
require "oidc/engine"

module Oidc
  # Block used to look up the keyset for the oidc controller based on where it
  # is mounted
  mattr_accessor :keyset_lookup
end
