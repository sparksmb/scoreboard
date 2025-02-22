import consumer from "channels/consumer"

consumer.subscriptions.create("BaseballGameChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("hooray connected...");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    document.getElementById("scoreboard").innerHTML = data.html;
  }
});
