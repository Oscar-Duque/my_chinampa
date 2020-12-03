const killed_btn = document.querySelectorAll(".killed-btn");

killed_btn.forEach((btn) => {
  btn.addEventListener('click', (event) => {
    event.preventDefault();
    event.stopPropagation();
    if (confirm('Really? killed your plant? Please do not do it again!')){
      // console.log('COUCOU');
      fetch( event.currentTarget.dataset.url, { method:'delete' });
    };
  });
});
