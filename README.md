# rbenv_resources
A resource cookbook for managing Ruby versions with [rbenv](https://github.com/rbenv/rbenv). This cookbook has *no* recipes. It exists purely to provide you with custom resources to use in your recipe cookbook.

## Platforms
This cookbook has been tested on the following platforms:

- Centos 7.2
- Ubuntu 16.04
- Ubuntu 14.04

## Resources

### rbenv_base
This is the main resource, used to install `rbenv` from its GitHub repo.

| attribute name | description                            | type                    | default value |
|----------------|----------------------------------------|-------------------------|---------------|
| prefix         | location where rbenv will be installed | String                  | '/opt'        |
| ruby_build     | install the ruby-build plygin          | [TrueClass, FalseClass] | true          |
| git_revision   | git revision to track                  | String                  | 'master'      |


### ruby_version
Use this resource to install different versions of Ruby. To see what versions are available, go [here](https://github.com/rbenv/ruby-build/tree/master/share/ruby-build).

| attribute name | description                | type   | required |
|----------------|----------------------------|--------|----------|
| version        | version of Ruby to install | String | true     |

### global_ruby
Use this resource to set the global Ruby version on your system.

| attribute name | description                        | type   | required |
|----------------|------------------------------------|--------|----------|
| version        | version of Ruby to enable globally | String | true     |

## Usage
Use the resources from this cookbook in the same way you would use the standard Chef-provided resources like `file` and `directory`. To make the resources available, make sure to add this line to your `metadata.rb`:

`depends 'rbenv_resources'`

To see an example of how the resources could be used in a recipe to install Ruby 2.2.2, see the [examples](https://github.com/davidcpell/rbenv_resources/tree/master/examples).

## Author
[David Pell](https://www.github.com/davidcpell)  
