# web3.cr

Ethereum Crystal API

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  web3.cr:
    github: light-side-software/web3.cr
```

## Usage

```crystal
require "web3"

web3 = Web3::Client.new "http://localhost:8545"
pp web3.client_version
pp web3.eth.syncing
```

## Contributing

1. Fork it ( https://github.com/light-side-software/web3.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [TamasSzekeres](https://github.com/TamasSzekeres) Tamás Szekeres - creator, maintainer
