const change_date = document.querySelector("#reminder_start_date");

change_date.addEventListener('change', (event) => {
  if (confirm("Are you sure?")) {
    document.querySelector(".simple_form.edit_reminder").submit();
  };
})
