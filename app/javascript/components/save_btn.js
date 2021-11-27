const saveBtn = () => {
  const button = document.getElementById("saveBtn");
  const text = document.getElementById("editorjs");

  text.addEventListener('dblclick', (event) => {

    button.classList.add("active");
  })

  const editorjsOuter = document.querySelector("body:not(#editorjs)") && button
  document.addEventListener('click', (event) => {

    button.classList.remove("active");
  })
}

export { saveBtn }
