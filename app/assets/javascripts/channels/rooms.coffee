jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
        channel: "ChatRoomsChannel"
        chat_room_id: messages.data('chat-room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server
        #@perform 'send_message', message: 'question', chat_room_id: 1  ==> DELETE THIS
         
      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append data['message']
        messages_to_bottom()
        #add more logic here

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

#experimenting...        
      bot_speak: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

#listening for POST button
    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length >= 1
        App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false

#listening for ENTER
    $("#new_message").on "keypress", (e) ->
      if e && e.keyCode == 13
        $this = $(this)
        textarea = $this.find('#message_body')
        if $.trim(textarea.val()).length >= 1
          App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
          textarea.val('')
        e.preventDefault()
        return false
        
        