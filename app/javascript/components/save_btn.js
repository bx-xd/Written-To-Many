const saveBtn = () => {
  const button = document.getElementById("saveBtn");
  const text = document.getElementById("editorjs");

  if (button) {
    text.addEventListener('mouseup', (event) => {
      event.preventDefault();
      button.classList.add("active");
    });
  }

  // if (button) {
  //   text.addEventListener('keyup', (event) => {
  //     event.preventDefault();
  //     button.classList.add("active");
  //   });
  // }
}

export { saveBtn }
