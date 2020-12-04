const change_date = document.querySelectorAll(".calendars");
for (let i = 0; i < change_date.length; i++) {
    const self = change_date[i];

  self.addEventListener('change', (event) => {
    if (confirm("Do you really want to change the date of your reminder?")) {
      self.parentElement.parentElement.submit();
    };
  });
}
