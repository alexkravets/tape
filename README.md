# Tape

*RSS reader for [Character CMS](https://github.com/slate-studio/chr).*


### Installation

Add to ```Gemfile```:

    gem 'tape', github: 'alexkravets/tape'

Add tape resource controllers to ```routes.rb```:

```ruby
# rss
resources :tape_subscriptions, controller: 'tape_subscriptions'
resources :tape_posts,         controller: 'tape_posts'
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
tape: new Tape('Tape', '/admin')
```


## Tape family

- [Character](https://github.com/slate-studio/chr): Powerful javascript CMS for apps
- [Mongosteen](https://github.com/slate-studio/mongosteen): An easy way to add restful actions for mongoid models
- [Inverter](https://github.com/slate-studio/inverter): An easy way to connect Rails templates content to CMS
- [Loft](https://github.com/slate-studio/loft): Media assets manager for Character CMS


## License

Copyright © 2015 [Alexander Kravets](https://github.com/alexkravets). Loft is free software, and may be redistributed under the terms specified in the [license](LICENSE.md).