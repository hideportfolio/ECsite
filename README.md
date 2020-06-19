## versions
- Rails: 5.2.4.1
- Ruby: 2.5.7

## 追加機能
### 検索機能
- 実装課題の要件としては商品の検索のみだったが、会員や検索手法の選択も可能になっている。
  - 応用課題5に近づけた形。

### public/orders#newでのフォーム制限
- application.jsと該当ビュー参照。

### デバッグ用
#### 該当Gem
```
gem 'pry-rails'
gem 'pry-byebug'
gem 'awesome_print'
gem 'hirb'
gem 'hirb-unicode-steakknife'
```

#### 使い方
- binding.pry / `rails c`
- Hirbが優先。
  - 最初に`ap`を付けると、awesome_printが有効化。
  - 一時的にHirbを無効化する場合は`Hirb.disable`。
  - →再度有効化する場合は`Hirb.enable`。
- `params`を入力時に、
> ActionController::UnfilteredParameters: unable to convert unpermitted parameters to hash
- こんなエラーが出る時がある。ヨクワカラナイ
  - そのまま読むと、"許可されてないパラメータをハッシュにできませんよ"と書いているので、`params.permit!`と、許可してあげればOK。
    - permit!は危険だそうです。注意。
  - ストロングパラメータ`○○_params`は、そこでpermitしているためエラーなく出力可。  
  - `params`をハッシュに変換しようとしているからか。 参考: https://qiita.com/h-shima/items/acf33cad8fd215ef9b96
    - `params.to_unsafe_h`だと、一時的なハッシュ変換なので、再度`params`を入力すると同じエラーになる(正常)

#### 参考記事
- https://wonderwall.hatenablog.com/entry/2015/08/07/211122
- https://qiita.com/mexelout/items/adc50b6233770f6f4377


### rubocop
- 静的コード解析ツール。カリキュラム参照。

### Jpostal
- 応用課題7参照。


## その他備忘録・コード
- [遷移先(=現在)のリクエスト取得]
```
Rails.application.routes.recognize_path(request.url)
→
{
    :controller => "public/registrations",
        :action => "new"
}

こんな感じでハッシュが出るので、
この末尾に[:controller],[:action]などつければそれぞれ出る。
```

- [遷移元(=一個前)のリクエスト取得]
```
Rails.application.routes.recognize_path(request.referer)

上と同様。
```

- [pryで`cd`とか`ls`とか使える]: https://qiita.com/k0kubun/items/b118e9ccaef8707c4d9f