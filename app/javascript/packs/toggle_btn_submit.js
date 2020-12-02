const change_btn = document.querySelectorAll(".toggles");
for (let i = 0; i < change_btn.length; i++) {
    const self = change_btn[i];

  self.addEventListener('click', (event) => {
    self.parentElement.parentElement.parentElement.submit();
    // const form = document.getElementbyId(`edit_reminder_${interpolacion}`)
    console.log(form);
  })
}
