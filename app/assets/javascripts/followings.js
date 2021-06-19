// 無限スクロール
$(document).on('turbolinks:load', function() {
  $('.follows').jscroll({
    contentSelector: '.follows',
    nextSelector: 'a.next',
    loadingHtml: '読み込み中'
  });
});