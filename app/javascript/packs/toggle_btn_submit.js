
const toggle = document.querySelector("#customSwitch1");

toggle.addEventListener('click', (event) => {
  event.preventDefault();
  document.querySelector(".simple_form.edit_reminder").submit();
})
