# att_chart

日経平均株価確認画面

## Getting Started

clone が完了したら、ターミナルで以下のコマンドを実施してください。

1. flutter をインストールしてください。https://www.sejuku.net/blog/123973
   1.1 Flutter SDK をダウンロード
   1.2 解凍した後、任意のフォルダに移動し、パスを通す(自分は develop フォルダを home 直下に作成し移動。以下 Mac 端末の場合)
   export PATH=~/xxxxxx/flutter/bin:$PATH
   source ~/.bash_profile
   1.3 「flutter doctor」をコマンドで実施し、開発に必要なパッケージを確認。（Mac は XCode を入れれば大丈夫。XCode 15 はビルド時にバグるため、15 を入れたら、ネットで対比策を実施してください。
2. flutter pub get (flutter packages get)
3. flutter clean
4. flutter run
