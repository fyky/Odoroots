document.addEventListener 'turbolinks:load', ->
  console.log($('#message').data('room_id'))
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#message').data('room_id') },
    connected: ->

    disconnected: ->

    received: (data) ->
      $('#messages').append data['message']

    speak: (message) ->
      @perform 'speak', { message: message, room_id: $('#message').data('room_id'), user_id: $('#message').data('user_id') }

  $('#chat-input').on 'keypress', (event) ->
    if event.keyCode is 13
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()