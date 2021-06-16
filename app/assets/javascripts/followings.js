$(document).on('turbolinks:load', function() {
  $('.follows').jscroll({
    // 無限に追加する要素は、どこに入れる？
    contentSelector: '.follows',
    // 次のページにいくためのリンクの場所は？ ＞aタグの指定
    nextSelector: 'a.next',
    // 読み込み中の表示はどうする？
    loadingHtml: '読み込み中'
  });
});