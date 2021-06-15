//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function(){
  function buildHTML(message) {
    var message = message.message ? `${ message.message }` : "";
    var html = `<div class="messages">
                  <% if messages.present? %>
                    <% messages.each do |message| %>
                      <% if message.user == current_user %>
                        <div class="right-message">
                          <div class="balloon-right">
                            <strong class="my-message">${ message.message }</strong>
                          </div>
                        </div>
                      <% else %>
                        <div class="left-message">
                          <div class="chat-icon">
                            <%= link_to user_path(message.user) do %>
                              ${ message.user.profile_image }
                            <% end %>
                            <div class="opponent-user">${ message.user.name }</div>
                          </div>
                          <div class="balloon-left">
                            <strong>${ message.message }</strong>
                          </div>
                        </div>
                      <% end %>
                    <% end %>
                  <% else %>
                    <h3 class="text-center">メッセージはまだありません</h3>
                  <% end %>
                </div>`
  return html;
  }
$('.message-form').on('submit', function(e){
    e.preventDefault();
    var message = new FormData(this);
    var url = (window.location.href);
    $.ajax({
      url: url,
      type: 'POST',
      data: message,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html);
      scrollBottom();
      function scrollBottom(){
        var html = buildHTML(message)
        var target = $('.messages').last();
        var position = target.offset().top + $('.messages').scrollTop();
        $('html,body').animate({ scrollTop: position }, 300, 'swing');
        $('#message_message').val(''); //input内のメッセージを消しています。
      }
    })
    .fail(function(data){
      alert ('メッセージ送信に失敗しました');
    })
    .always(function(data){
      $('.messsage-submit-btn').prop('disabled', false);　//ここで解除している
    })
  })
});