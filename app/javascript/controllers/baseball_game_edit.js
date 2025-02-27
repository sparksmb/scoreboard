document.addEventListener("turbo:load", function() {
  console.log("JavaScript is loaded!"); // This should now always appear

  document.querySelectorAll(".home-run-btn").forEach(function(button) {
    button.addEventListener("click", function(event) {
      event.preventDefault();

      console.log("homerun!!!!!!!!!!!!!!!!!!!!!!!!");
      let team = event.currentTarget.dataset.team;
      console.log("Team selected:", team);

      let hiddenInput = document.getElementById("home-run-input");
      hiddenInput.value = team; // Set the value to "home" or "away"

      document.getElementById("score-form").requestSubmit(); // Use requestSubmit() for better Turbo handling
    });
  });
});
