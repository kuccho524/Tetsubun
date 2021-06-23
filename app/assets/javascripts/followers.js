// 無限スクロール
$(document).on('turbolinks:load', function() {
  $('.followers').jscroll({
    // 無限に追加する要素は、どこに入れる？
    contentSelector: '.followers',
    // 次のページにいくためのリンクの場所は？ ＞aタグの指定
    nextSelector: 'a.next',
    // 読み込み中の表示はどうする？
    loadingHtml: '読み込み中'
  });
});