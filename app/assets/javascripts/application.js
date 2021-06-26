// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require popper
//= require jquery.jscroll.min.js
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require_tree .

// 画像スライダー
$(document).ready(function () {
  $("#train-images").skippr({
    transition : 'slide',
    speed : 1000,
    easing : 'easeOutQuart',
    navType : 'bubble',
    childrenElementType : 'div',
    arrows : true,
    autoPlay : true,
    autoPlayDuration : 3000,
    keyboardOnAlways : true,
    hidePrevious : false
  });
});

// 矢印クリック時にトップへ戻る
$(function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});

// チャットルームへ遷移した時、メッセージ入力欄表示する
document.addEventListener("turbolinks:load", function (event) {
  // console.info(`Network Call Avoidance Workaround (for Turbolinks) attempting to short-circuit network calls.`);
  const current_url = event.data.url; // Destination URL

  //console.log(current_url);
  const re = /.*\/rooms\/\d/
  if (re.test(current_url)) {
    //console.log('room!');
    const obj = document.getElementById('message_message');
    obj.scrollTop = obj.scrollHeight;
    const element = document.documentElement;
    const bottom = element.scrollHeight - element.clientHeight;
    window.scroll(0, bottom);
  }
});

// 記事に対しての画像プレビュー
$(function(){
    $(document).on('change', '.train_image', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".train_image").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});

// ユーザに対しての画像プレビュー
$(function(){
    $(document).on('change', '.user_image', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".profile_image").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});

function addToNewUrl() {
  let path = location.pathname;
  let pattern = /^.*\/new.*$/

  // URLが正しければ変更は不要
  if(path.match(pattern)) return;

  // URLを変更
  history.replaceState('', '', `${ path }/new`)
}

function addToEditUrl() {
  let path = location.pathname;
  let pattern = /^.*\/edit.*$/

  // URLが正しければ変更は不要
  if(path.match(pattern)) return;

  // URLを変更
  history.replaceState('', '', `${ path }/edit`)
}

function addToSignUpUrl() {
  let path = location.pathname;
  let pattern = /^.*\/sign_up.*$/

  // URLが正しければ変更は不要
  if(path.match(pattern)) return;

  // URLを変更
  history.replaceState('', '', `${ path }/sign_up`)
}