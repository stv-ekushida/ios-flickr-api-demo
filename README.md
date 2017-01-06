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
| Model        | PhotoSearch | PhotoSearchResults                 | 写真検索APIのレスポンスデータ（第一階層） |
|              |             | Photos                             | 写真検索APIのレスポンスデータ（第二階層） |
|              |             | Photo                              | 写真検索APIのレスポンスデータ（第三階層） |
|              |             | PhotoSearchAPI                     | 写真検索APIを送信するクラス |
|              |             | PhotoSearchLoadable                | 写真検索APIの検索結果を通知するプロトコル |
|              |             | PhotoSearchParamsBuilder           | 写真検索APIのリクエストパラメタを作成するクラス |
|              |             | PhotoImageURLBuilder               | 画像のURLを作成するクラス |
|              | Common      | FlickrBaseParamsBuilder            | Flickr APIの共通パラメタを作成するクラス |
| View         | PhotoList   | PhotoListCollectionView            | CollectionViewを作成するクラス |
|              |             | PhotoListCollectionViewCell        | CollectionViewCellを作成するクラス（正常系） |
|              |             | PhotoListIllegalCollectionViewCell | CollectionViewCellを作成するクラス（例外系） |
|              |             | PhotoListStatus                    | 写真一覧の状態(enum) |
|              |             | PhotoListStatusType                | 写真一覧表示用のプロトコル |
|              |             | PhotoListFactory                   | 状態ごとに、写真一覧画面を管理するクラス |
|              |             | PhotoListStatusNone                | 写真一覧表示用クラス(未処理) |
|              |             | PhotoListStatusLoading             | 写真一覧表示用クラス(ロード中) |
|              |             | PhotoListStatusNormal              | 写真一覧表示用クラス(データが1件以上ある場合) |
|              |             | PhotoListStatusNoData              | 写真一覧表示用クラス(データが0件の場合) |
|              |             | PhotoListStatusOffline             | 写真一覧表示用クラス(オフラインの場合) |
| Controller   | PhotoList   | PhotoListViewController            | 写真一覧画面クラス |
| Util         |             | APIClient                          | APIクライアントクラス |
|              |             | NetworkManager                     | ネットワークの状態を管理するクラス |
|              |             | Router                             | API用のオブジェクト(enum) |
