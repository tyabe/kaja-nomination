# Kaja Nomination

RubyKajaの投票用WEBアプリケーションです

## 動かし方
```
# Bundler version 1.2.0.pre.1 がインストールされている必要があります
$ gem install bundler --pre
$ git clone git@github.com:tyabe/kaja-nomination.git
$ cd kaja-nomination
$ bundle install --without production
$ padrino rake seed
$ padrino s
```

distributed under the [MIT License](http://tyabe.mit-license.org/)
