// 無限スクロール
$(document).on('turbolinks:load', function() {
  $('.train-index').jscroll({
    contentSelector: '.train-index',
    nextSelector: 'a.next',
    loadingHtml: '読み込み中'
  });
});