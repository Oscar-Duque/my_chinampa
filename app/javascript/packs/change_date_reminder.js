const change_date = document.querySelectorAll("#reminder_start_date");
for (let i = 0; i < change_date.length; i++) {
    const self = change_date[i];

  self.addEventListener('change', (event) => {
    if (confirm("Do you reaaly want to change the date of your reminder?")) {
      document.querySelector(".simple_form.edit_reminder").submit();
    };
  });
}
