const toggle = document.querySelector("#customSwitch1");

toggle.addEventListener('click', (event) => {
  document.querySelector(".simple_form.edit_reminder").submit();
})
