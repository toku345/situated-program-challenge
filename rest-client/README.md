# Requirement

- Ruby : (開発では2.5.0を使用)
- bundler : (開発では1.16.1を使用)

※ DBは docker-compose などで立ち上げておいてください

# Installation

    $ cd rest-client
    $ bundle install

# Usage

## GET リクエスト

    $ ruby client.rb get {url}

## POST リクエスト

    $ ruby client.rb post {url} '{JSONデータ}'


# Sample Commands

## ミートアップエンティティ

### ミートアップイベント一覧情報の取得

    $ ruby client.rb get http://localhost:3000/groups/1/meetups

### ミートアップイベントの登録

    $ ruby client.rb post http://localhost:3000/groups/1/meetups '{"title":"テストミートアップ","start-at":"2018-01-16T00:07:39.140Z","end-at":"2018-01-16T00:07:39.140Z","venue-id":1}'

### ミートアップイベント情報の取得

    $ ruby client.rb get http://localhost:3000/groups/1/meetups/1


## メンバーエンティティ

### メンバー一覧情報の取得

    $ ruby client.rb get http://localhost:3000/members

### メンバーの登録

    $ ruby client.rb post http://localhost:3000/members '{"first-name":"Rich","last-name":"Hickey","email":"rich@sample.com"}'

### メンバー情報の取得

    $ ruby client.rb get http://localhost:3000/members/1

### ミートアップへの参加

    $ ruby client.rb post http://localhost:3000/members/3/meetups/1

### グループへの参加

    $ ruby client.rb post http://localhost:3000/members/3/groups/1 '{"admin":false}'




## 会場エンティティ

### 会場一覧の取得

    $ ruby client.rb get http://localhost:3000/groups/1/venues

### 会場の登録

    $ ruby client.rb post http://localhost:3000/groups/1/venues '{"venue-name":"福岡会場","address":{"postal-code":"813-0035","prefecture":"福岡県","city":"福岡市","address1":"東区","address2":"松崎"}}'




## グループエンティティ

### グループ一覧の取得

    $ ruby client.rb get http://localhost:3000/groups

### グループの登録

    $ ruby client.rb post http://localhost:3000/groups '{"group-name":"TEST GROUP","admin-member-ids":[1,2]}'
