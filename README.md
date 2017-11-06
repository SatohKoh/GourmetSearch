# GourmetSearch

## 概要
食べログのように周辺のお店を条件検索できるアプリ

## 機能
- 店舗一覧
- 店舗詳細
- フリーワード検索
- 外部APIアクセス
- P2R
- 無限スクロール

## 画面フロー
### 検索タブ
- 検索トップ
  - キーワードで検索する
  - スコア順に表示
- 店舗一覧
  - 店舗一覧がセルに表示される
- 店舗詳細
  - 店舗名，写真，電話番号，住所，地図，お気に入りを表示する
  
### お気に入りタブ
- お気に入り店舗一覧
-　店舗詳細

## 店舗データ
### ローカルサーチAPI
> https://developer.yahoo.co.jp/webapi/map/openlocalplatform/v1/localsearch.html

### アプリケーション登録(Yahoo Japan ID が必要)
> https://e.developer.yahoo.co.jp/register

アプリケーションIDを取得する

## 使用するライブラリ
- Alamofire
- SwiftyJSON
- SDWebImage
