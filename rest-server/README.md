# Requirement

- Ruby : (開発では2.5.0を使用)
- bundler : (開発では1.16.1を使用)
- PostgreSQL 9.0 or later (with headers, -dev packages, etc) : gem 'pg' のコンパイルに必要

※ DBは docker-compose などで立ち上げておいてください

# Installation

    $ cd rest-server
    $ bundle install

# Usage

## サーバー起動

    $ ./bin/rails server

## REPL起動

    $ ./bin/rails console

## テスト実行

    $ ./bin/bundle exec rspec

### ファイル更新を契機にテスト実行させる

    $ ./bin/bundle exec guard

### ER図作成

    $ ./bin/rake erd
