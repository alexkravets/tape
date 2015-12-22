# Tape

*RSS reader for [Character](https://github.com/slate-studio/chr) based website.*


### Installation

Add to ```Gemfile```:

    gem 'tape-chr'

Add tape resource controllers to ```routes.rb```:

```ruby
  mount_tape_subscriptions_crud
  mount_tape_posts_crud
```

Add to ```admin.scss``` and ```admin.coffee```:

```scss
@import "tape";
```

```coffee
#= require tape
```

Add to ```admin.coffee``` character configuration object:

```coffee
tape: new Tape()
```


## Tape family

- [Character](https://github.com/slate-studio/chr): Powerful javascript CMS for apps
- [Mongosteen](https://github.com/slate-studio/mongosteen): An easy way to add restful actions for mongoid models
- [Inverter](https://github.com/slate-studio/inverter): An easy way to connect Rails templates content to CMS
- [Loft](https://github.com/slate-studio/loft): Media assets manager for Character CMS


## License

Copyright © 2015 [Alexander Kravets](https://github.com/alexkravets). Loft is free software, and may be redistributed under the terms specified in the [license](LICENSE.md).