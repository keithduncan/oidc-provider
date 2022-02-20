# OpenID Connect Provider

Proof-of-concept OpenID Connect provider Rails engine with support for
per-tenant keysets.

Tenants can be arbitrarily deep in your object model. For example, your keyset
could be service-wide, per-organisation, or per-organisation cluster. Whatever
makes sense to be a root of trust in your object model.

Mount the engine in your application routes at a path parameterised by the
tenant e.g. `/organization/:org_slug/oidc`

## Usage

1. Install the gem.
2. Install and run the engine’s migrations `rake oidc:install:migrations db:migrate`.
3. Backfill or create just-in-time keysets for your tenants.
4. Create a database (`Oidc::Key::Db`) or AWS KMS (`Oidc::Key::Kms`) signing key
for each keyset, see [Keys](#keys).

5. Mount the Rails engine in your routes as a resource on your model’s root of
trust:

```ruby
Rails.application.routes.draw do
  resources :organizations, only: [:show] do
    mount Oidc::Engine, at: "oidc", as: "oidc"
  end
end
```

6. Provide an `Oidc.keyset_lookup` function in `config/initializers/oidc.rb`
that uses the route params to look up and return the tenant’s keyset.

## Keys

There are two key models: [`Oidc::Key::Db`](app/models/oidc/key/db.rb), and
[`Oidc::Key::Kms`](app/models/oidc/key/kms.rb).

`Oidc::Key::Db` stores the RSA private key material in the database and can be
used for local development and prototyping. The `private_key` field should be
set to an unencrypted PEM encoded RSA private key. You can optionally store the
public key in the `public_key` field, otherwise the public key components will
be extracted from the private key when needed.

`Oidc::Key::Kms` uses an AWS KMS Asymmetric RSA key for signing operations. The
`private_key` field is an AWS KMS Key ARN. The KMS Key must be an RSA key. The
`public_key` field is the KMS key’s public key in PEM format. Signing operations
depend on network connectivity to the AWS KMS region hosting the key.

## Examples

- [`examples/service-wide`](examples/service-wide) a single service-wide keyset
- [`examples/tenant`](examples/tenant) a per-organisation keyset, single tenant
- [`examples/per-tenant`](examples/per-tenant) a per-organisation cluster keyset, multi-tenant

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'oidc'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install oidc
```

## Contributing
Fork the repository and open a pull request.

## License
The gem is available as open source under the terms of the [AGPL-3.0 License](https://opensource.org/licenses/AGPL-3.0).
