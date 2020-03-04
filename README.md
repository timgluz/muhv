# Muhv

A little small fluffy helper to make easier to get started with new projects;

## Installation

1. install thor

```bash
gem install thor
```

2. clone the repo

```bash
git clone git@github.com:timgluz/muhv.git
```

3. install the gem version

```
bin/setup
```


#### Dev version

clone the repo and code is executable like this:

```bash
./bin/muhv

# old version without Zeitwerk
RUBYLIB=lib/ ./bin/muhv
```

## Usage

#### Generate project for Ruby' Dry lambda

`$> muhv drylambda xample`

Result:

```bash
.
├── .editorconfig
├── .gitignore
├── .overcommit.yml
├── .rubocop.yml
├── .ruby-gemset
├── .ruby-version
├── Gemfile
├── Gemfile.lock
├── Makefile
├── README.md
├── app
│   ├── functions
│   │   ├── base_dry_function.rb
│   │   └── health.rb
│   ├── functions.rb
│   ├── lib
│   │   └── hash.rb
│   ├── services
│   │   └── base_dry_service.rb
│   └── services.rb
├── handlers.rb
├── loader.rb
├── serverless.yml
└── spec
    ├── functions
    │   └── health_spec.rb
    └── spec_helper.rb

6 directories, 23 files
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/timgluz/muhv.
