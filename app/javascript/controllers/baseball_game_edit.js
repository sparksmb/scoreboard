document.addEventListener("turbo:load", function() {
  console.log("JavaScript is loaded!"); // This should now always appear

  document.querySelectorAll(".action-btn").forEach(function(button) {
    button.addEventListener("click", function(event) {
      event.preventDefault();

      console.log("homerun!!!!!!!!!!!!!!!!!!!!!!!!");
      let action = event.currentTarget.dataset.action;

      let hiddenInput = document.getElementById("action-input");
      hiddenInput.value = action;

      document.getElementById("score-form").requestSubmit(); // Use requestSubmit() for better Turbo handling
    });
  });
});
