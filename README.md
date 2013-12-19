Committers/holidays-l
=====================
- [holidays-l開発ブログ](http://d.hatena.ne.jp/holidays-l/)
- [Robario Tech @robario](http://www.robario.com/)

[/lang/actionscript/misc/holidays-l/console.as](/lang/actionscript/misc/holidays-l/console.as)
----------------------------------------------------------------------------------------------
Firebugのconsoleみたいなことをします。
最初mx.logging.*でやろうとしてたんだけど、ILoggerのインターフェイスがStringしか受け付けてくれないのでこんなものになってしまいました。

### 誰か書いて
- 速くして
- Firebug Console API全部実装して

[lang/javascript/console/](lang/javascript/console/)
----------------------------------------------------
Firebugのconsoleみたいなことをします。

### 誰か書いて
- alertうざいでーす（ぉ

[lang/perl/Catalyst-Controller-Delegate/](lang/perl/Catalyst-Controller-Delegate/)
----------------------------------------------------------------------------------
Delegateの`-_-`みたいなことをします。

### 誰か書いて
- 多段できませーん（ぉ

[lang/javascript/misc/loader.js.inc](lang/javascript/misc/loader.js.inc)
------------------------------------------------------------------------
[圧縮版：lang/javascript/misc/loader-min.js.inc](lang/javascript/misc/loader-min.js.inc)

JavaScriptで外部ライブラリが簡単に読み込めるようになるスクリプトなのです。

詳しくは[holidays-l開発ブログ - JavaScriptで外部ライブラリを読み込むためのスクリプトをCodeRepos.orgに上げた。](http://d.hatena.ne.jp/holidays-l/20070923/p1)を見てください（＞＜）

[lang/perl/WebService-YouTube](lang/perl/WebService-YouTube)
------------------------------------------------------------

### 誰か書いてください（＞＜）
- ''The older API is still functional, but officially deprecated.''って言われちゃってるのでGData APIへ移行
- アダルトコンテンツの年齢チェックページ対応
  @See <a href="http://rt.cpan.org/Public/Bug/Display.html?id=24429">#24429: Accessing videos behind "adults only" screen?</a>
- ~~get_video_uri は http://cache.googlevideo.com/get_video?video_id=${video_id} を使えばスクレイピングする必要がない。デフォルトでgooglevideoにしておいて、youtube.comも選べるようにするとか？~~
   できなくなってるみたいですね。

[lang/javascript/misc/password.js](lang/javascript/misc/password.js)
--------------------------------------------------------------------
パスワードジェネレータなのです。
各サイトでパスワードを違うものにしたいけど、全部覚えられないのでこれ使ってます。

### 使い方

#### 事前準備（一度だけ）
1. 以下のブックマークレットをブックマーク（お気に入り）に登録する

   ```javascript
javascript:(function(s){s.src='https://raw.github.com/robario/CodeRepos/14fe4498bce0ba9948cacb182d430e015499be00/lang/javascript/misc/password.js';document.documentElement.appendChild(s)})(document.createElement('script'))
```
   - （javascript:...なリンクが作れない・・・）
   - （念の為にRevisionを指定しておいた方が良いと思いますです。。。）

#### 使用時
1. ブックマークレットを実行する
1. ドメイン名を入力する（デフォルトでよければそのままEnter）
1. マスターキーを入力する
1. パスワード欄に暗号化パスワードが自動的に入力される
1. (ﾟДﾟ)ｳﾏｰ

暗号化パスワードは3秒間見えるように（`*********`ではない状態に）なっています。「なんで？」とか聞かないで。
サイトによっては`*********`になってないと受け付けない場合があるため、その場合は`*********`になるまで少し待ってから送信してください。

### TODO
- SHA1ライブラリを直接password.js内に埋め込む（BSDなファイルって混ぜてもいいんだっけ？いいならsha1.jsを埋め込めばOK）
- （もし暗号化方式が気にいらない人がいれば）アルゴリズムを切り替えられるようにするとか？

[lang/javascript/JSONScriptRequest/](lang/javascript/JSONScriptRequest/)
------------------------------------------------------------------------

### TODO?
- XMLHttpRequestと交換可能にする

  `window.XMLHttpRequest = JSONScriptRequest`としたときに同じ挙動をするように。

[lang/javascript/Object.toSource/](lang/javascript/Object.toSource/)
--------------------------------------------------------------------

### TODO
- 色々動いてないと思うので誰かに直してもらう。

[platform/google-gadgets/youtubeplayerlite.xml](platform/google-gadgets/youtubeplayerlite.xml)
----------------------------------------------------------------------------------------------
[YouTube Flash Player](http://fplayer.youtubech.com/)さんとこのYouTube Player LiteをGoogle Gadgetsとして表示します。

ガジェットを追加するには以下のURLを使ってください。
https://raw.github.com/robario/CodeRepos/master/platform/google-gadgets/youtubeplayerlite.xml
