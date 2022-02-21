# OpenID Connect Provider

Proof-of-concept OpenID Connect provider Rails engine with support for
per-tenant keysets.

Tenants can be arbitrarily deep in your object model. For example, your keyset
could be service-wide, per-organisation, or per-organisation resource. Whatever
makes sense to be a root of trust in your object model.

<img width="1129" alt="Screen Shot 2022-02-21 at 11 08 37" src="https://user-images.githubusercontent.com/22101/154870621-178cc98c-e83a-44b9-9877-2d124e5efefa.png">

While you can use a single service-wide root of trust for your provider and
disambiguate principals using a subject claim (a la GitHub Actions), this engine
supports multiple roots providing more isolation between principals.

Mount the engine in your application’s routes at a path parameterised by the
tenant in your model with an associated keyset e.g. `/organization/:org_slug/oidc`.
The engine renders resources for `.well-known/openid-configuration` and `keyset`
allowing mounted instances to function as an OpenID Connect Identity Provider (IdP)
for a relying party (RP) such as AWS IAM.

## Usage

1. Install the gem.
2. Install and run the engine’s migrations `rake oidc:install:migrations db:migrate`.
3. Add a `belongs_to` relationship from your tenant to an `Oidc::Keyset`.
4. Backfill or create just-in-time keysets for your tenants.
5. Create a database (`Oidc::Key::Db`) or AWS KMS (`Oidc::Key::Kms`) signing key
for each keyset, see [Keys](#keys).

6. Mount the Rails engine in your routes as a resource on your model’s root of
trust, e.g.:

```ruby
Rails.application.routes.draw do
  resources :organizations, only: [:show] do
    mount Oidc::Engine, at: "oidc", as: "oidc"
  end
end
```

7. Provide an `Oidc.keyset_lookup` function in `config/initializers/oidc.rb`
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
