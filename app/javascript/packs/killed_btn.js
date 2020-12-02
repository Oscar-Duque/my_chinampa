const killed_btn = document.querySelectorAll(".killed-btn");

killed_btn.forEach((btn) => {
  btn.addEventListener('click', (event) => {
    event.stopPropagation();
    debugger
    if (confirm('Really? killed your plant? Please do not do it again!')){
      // console.log('COUCOU');
      event.target.parentElement.parentElement.parentElement.preventDefault();
      fetch( event.currentTarget.dataset.url, { method:'delete' });
    };
  });
});
