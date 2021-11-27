const saveBtn = () => {
  const button = document.getElementById("saveBtn");
  const text = document.getElementById("editorjs");

  text.addEventListener('dblclick', (event) => {
    event.preventDefault();

    button.classList.add("active");
  })

  const editorjsOuter = document.querySelector("body:not(#editorjs)")
  document.addEventListener('click', (event) => {
    event.preventDefault();

    button.classList.remove("active");
  })
}

export { saveBtn }
