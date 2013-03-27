# Kaja Nomination

RubyKajaの投票用WEBアプリケーションです

## 動かし方
```
$ git clone git@github.com:tyabe/kaja-nomination.git
$ cd kaja-nomination
$ bundle install
$ padrino rake seed
$ padrino s
```

## 本番環境
* Dalli を使用しています
* Github の OAuth 情報が必要です
* Twitter の OAuth 情報とアクセストークンが必要です
* Facebook の OAuth 情報が必要です

distributed under the [MIT License](http://tyabe.mit-license.org/)
