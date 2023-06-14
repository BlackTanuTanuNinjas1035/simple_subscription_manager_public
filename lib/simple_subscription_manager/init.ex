defmodule SimpleSubscriptionManager.Init do
  alias SimpleSubscriptionManager.Subscriptions.Subscription
  alias SimpleSubscriptionManager.Accounts.Account
  alias SimpleSubscriptionManager.Subscribes.Subscribe
  alias SimpleSubscriptionManager.Subscriptions.Genre
  alias SimpleSubscriptionManager.Documents.Document
  alias SimpleSubscriptionManager.Topics.Topic
  alias SimpleSubscriptionManager.Talks.Talk
  alias SimpleSubscriptionManager.Repo

  def init() do
    Repo.insert(%Genre{name: "動画配信のサービス"})
    Repo.insert(%Genre{name: "音楽配信のサービス"})
    Repo.insert(%Genre{name: "カーレンタルのサービス"})
    Repo.insert(%Genre{name: "食品のサービス"})
    Repo.insert(%Genre{name: "ソフトウェア提供のサービス"})
    Repo.insert(%Genre{name: "家具・家電のサービス"})
    Repo.insert(%Genre{name: "習い事や趣味のサービス"})
    Repo.insert(%Genre{name: "本のサービス"})
    Repo.insert(%Subscription{name: "Youtubeプレミア", genre_id: 1, price: 1180, description: "YoutubeプレミアムのYoutubeとの違いは、広告が表示されなくなること、そして動画のダウンロードができることです。こちら、「Youtube Musicプレミアム」を含まない単体のサービスの金額となります。"})
    Repo.insert(%Subscription{name: "AbemaTV プレミア", genre_id: 1, price: 960, description: "省略"})
    Repo.insert(%Subscription{name: "U-NEXT", genre_id: 1, price: 2189, description: "省略"})
    Repo.insert(%Subscription{name: "Hulu", genre_id: 1, price: 1026, description: "省略"})
    Repo.insert(%Subscription{name: "Disney+", genre_id: 1, price: 990, description: "省略"})
    Repo.insert(%Subscription{name: "Netflix(ベーシック)", genre_id: 1, price: 990, description: "省略"})
    Repo.insert(%Subscription{name: "Amazon Prime Video", genre_id: 1, price: 500, description: "省略"})
    Repo.insert(%Subscription{name: "Apple Music(学生)", genre_id: 2, price: 580, description: "省略"})
    Repo.insert(%Subscription{name: "Apple Music(個人)", genre_id: 2, price: 980, description: "省略"})
    Repo.insert(%Subscription{name: "Apple Music(ファミリー)", genre_id: 2, price: 1480, description: "省略"})
    Repo.insert(%Subscription{name: "Spotify", genre_id: 2, price: 980, description: "年額のほうが安くなるよ"})
    Repo.insert(%Subscription{name: "Spotify(カップルプラン)", genre_id: 2, price: 1280, description: "省略"})
    Repo.insert(%Subscription{name: "Spotify(ファミリーブラン)", genre_id: 2, price: 980, description: "省略"})
    Repo.insert(%Subscription{name: "Spotify(学生プラン)", genre_id: 2, price: 980, description: "省略"})
    Repo.insert(%Subscription{name: "SOMPOで乗ーる(ダイハツ・ミライース: ライトメンテプラン", genre_id: 3, price: 26800, description: "表示価格はあくまで概算での価格と表記されていた。実際にアプリを稼働させるとして、店舗ごとに利用料金が変わるタイプのサービスは、その企業との連携が必要になるかもです。(データ入力してもらうとか)"})
    Repo.insert(%Subscription{name: "nosh-ナッシュ(10食:2周間)", genre_id: 4, price: 5990, description: "プランが別れているものを個別のサービスとして登録するとジャンルごとのサービスの数に偏りが出る(確定で)ので困りもの"})
    Repo.insert(%Subscription{name: "Microsoft 365(家庭向けプラン)", genre_id: 5, price: 1284, description: "省略"})
    Repo.insert(%Subscription{name: "Google Workspace(Business Standard)", genre_id: 5, price: 1360, description: "省略"})
    Repo.insert(%Subscription{name: "Creative Cloudコンプリートプラン", genre_id: 5, price: 6480, description: "Photoshop、Illustrator、Adobe Express、Premiere Pro、Acrobat Proなど、20以上のCreative Cloudアプリをご利用いただけます。"})
    Repo.insert(%Document{
      format: "{\"num_of_user\": 登録情報の利用許可を出しているユーザの人数, \"percent\": 全体の割合}",
      name: "/api/available-user",
      text: "サブスクーラーを利用しているユーザのうち、登録情報の利用許可を出しているユーザの人数と全体の割合を返却します。"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"description\": サービス説明,
            \"genre\": ジャンル名,
            \"name\": サービス名,
            \"price\": 料金,
          }, ...
      ]",
      name: "/api/service-list",
      text: "サブスクーラーに登録されているサービスの一覧を返します。"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"name\": ジャンル名,
            \"id\": ジャンルID,
          }, ...
      ]",
      name: "/api/service-list",
      text: "サブスクーラーに登録されているジャンルの一覧を返します。"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"genre\": ジャンル名,
            \"name\": サービス名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/service-ranking/",
      text: "登録されているサービスのランキングを返します。"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"genre\": ジャンル名,
            \"name\": サービス名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/service-ranking/:gender",
      text: "男性、または女性ごとの登録されているサービスのランキングを返します。(男性: 1, 女性: 2)"
    })

    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"genre\": ジャンル名,
            \"name\": サービス名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/service-ranking/age/:age",
      text: "年代別の登録されているサービスのランキングを返します。(男性: 1, 女性: 2)"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"genre\": ジャンル名,
            \"name\": サービス名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/service-ranking/:gender/:age",
      text: "男性、または女性ごとの年代別の登録されているサービスのランキングを返します。(男性: 1, 女性: 2)"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"name\": ジャンル名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/genre-ranking/",
      text: "登録されているサービスのジャンルのランキングを返します。"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"name\": ジャンル名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/genre-ranking/:gender",
      text: "男性、または女性ごとの登録されているサービスのジャンルのランキングを返します。"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"name\": ジャンル名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/genre-ranking/age/:age",
      text: "年代別の登録されているサービスのジャンルのランキングを返します。"
    })
    Repo.insert(%Document{
      format: "[
        {
            \"percent\": 全体の割合,
            \"name\": ジャンル名,
            \"point\": 登録件数,
          }, ...
      ]",
      name: "/api/genre-ranking/:gender/:age",
      text: "男性、または女性ごとの年代別の登録されているサービスのジャンルのランキングを返します。"
    })

    Repo.insert(%Topic{title: "Creative Cloudコンプリートプランを追加しました", text: "登録できるサービスにCreative Cloudコンプリートプランを追加しました。\nまた追加してほしいサービスがございましたらお問い合わせフォームから連絡ください。", genre: "サービスの追加"})
    Repo.insert(%Topic{title: "サブスクーラーの稼働開始", text: "登録できるサービスにCreative Cloudコンプリートプランを追加しました。また追加してほしいサービスがございましたらお問い合わせフォームから連絡ください。", genre: "運営からのお知らせ"})
    Repo.insert(%Topic{title: "お問い合わせフォームの追加", text: "サブスクーラーに登録してほしいサービスを投稿できるフォームを作成しました。お気軽に希望のサービスを入力してください。", genre: "機能の追加"})
    Repo.insert(%Topic{title: "お問い合わせフォームの変更", text: "既存のフォームを作成し、問い合わせの種類を指定して内容を記入するように変更しました。", genre: "機能の変更"})

  end
end
