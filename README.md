# ios-flickr-api-demo

|Category | Version| 
|---|---|
| Swift | 3.0.2 |
| XCode | 8.2.1 |
| Cocoa Pods | 1.1.1 |
| iOS | 10.0〜 |

## Usage Library
git cloneしたあとに、pod installしてください。

| Library | Description |
|---|---|
| Alamofire | HTTP networking library |
| AlamofireImage | Image component library |
| ObjectMapper | JSON Object Mapping library |

## Class Configuration

| Directory |             | Naming                               | Description                                      |
|--------------|-------------|------------------------------------|-------------------------------------------------|
| Model        | PhotoSearch | PhotoSearchAPI                     | 写真検索APIを送信するクラス                     |
|              |             | PhotoSearchLoadable                | 写真検索APIの検索結果を通知するプロトコル          |
|              |             | PhotoSearchParamsBuilder           | 写真検索APIのリクエストパラメタを作成するクラス       |
|              |             | PhotoSearchStatus                  | 写真検索結果取得後の状態クラス                  |
|              |             | PhotoSearchResults                 | 写真検索APIのレスポンスデータ（第一階層）           |
|              |             | Photos                             | 写真検索APIのレスポンスデータ（第二階層）           |
|              |             | Photo                              | 写真検索APIのレスポンスデータ（第三階層）           |
|              |             | PhotoImageURLBuilder               | 画像のURLを作成するクラス                       |
|              | Common      | FlickrBaseParamsBuilder            | Flickr APIの共通パラメタを作成するクラス           |
| View         | PhotoSearch | PhotoListCollectionView            | CollectinViewを作成するクラス                   |
|              |             | PhotoListCollectionViewCell        | CollectionViewCellを作成するクラス（通常）         |
|              |             | PhotoListIllegalCollectionViewCell | CollectionViewCellを作成するクラス              |
| Controller   | PhotoList   | PhotoListViewController            | 写真一覧画面クラス                              |
| Util         |             | APIClient                          | APIクライアントクラス                           |
|              |             | NetworkManager                     | ネットワークの状態を管理するクラス              |
|              |             | Router                             | API用のオブジェクトを作成するクラス             |
