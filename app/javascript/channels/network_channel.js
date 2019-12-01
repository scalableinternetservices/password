import consumer from "./consumer"

consumer.subscriptions.create("NetworkUserChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // const script_str = document.body.querySelector("script").childNodes[0].wholeText
    // var script_list = script_str.split(";")
    App.edges.add({from: data[0], to: data[1]})
  }
});