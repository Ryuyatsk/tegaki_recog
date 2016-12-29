# tegaki_recog

機械学習向けに使用できる前処理用アプリです。
「画像からテキストを認識する」ために、画像の一部に対応するテキストのラベル付を素早く行えます。

詳しくは Qiita の「機械学習の学習で使用する画像抽出とラベル付けができる前処理アプリをRailsで作ってみた」を御覧ください。

# 完成イメージ

## 手作業によるラベル付け

![tegaki01.gif](https://github.com/ryo813/tegaki_recog/blob/master/app/assets/movies/tegaki01.gif)

前処理として行うことは以下の通りです。
１．切り取りたい範囲の座標をクリックで選択
２．対応するテキストを書き込みラベル付け

## ラベル付けしたデータのダウンロード

ラベル付けを行ったデータをCSVファイルとして簡単にダウンロードできるようにしています。

![tegaki02.gif](https://github.com/ryo813/tegaki_recog/blob/master/app/assets/movies/tegaki02.gif)
