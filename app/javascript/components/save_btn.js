const saveBtn = () => {
  const button = document.getElementById("saveBtn");
  const text = document.getElementById("editorjs");

  if (button) {
    text.addEventListener('dblclick', (event) => {
      event.preventDefault();

      button.classList.add("active");
    })
  }

  // const editorjsOuter = document.querySelector("body:not(#editorjs)") && button
  // document.addEventListener('click', (event) => {

  //   button.classList.remove("active");
  // })
}

export { saveBtn }
