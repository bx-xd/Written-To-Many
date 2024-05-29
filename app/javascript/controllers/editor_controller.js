import { Controller } from "@hotwired/stimulus";
import EditorJS from "@editorjs/editorjs";
import Header from "@editorjs/header";
import List from "@editorjs/list";
import Paragraph from "@editorjs/paragraph";

class CustomParagraph extends Paragraph {
  set data(data) {
    this._data = data || {};

    this._element.innerHTML = this._data.text || "";
    this._element.classList.add(this._data.class);
    this._element.setAttribute("data-id", this._data.id);
  }
}
class CustomHeader extends Header {
  normalizeData(data) {
    const newData = {};

    if (typeof data !== "object") {
      data = {};
    }

    newData.text = data.text || "";
    newData.level = parseInt(data.level) || this.defaultLevel.number;
    newData.class = data.class || "";
    newData.id = data.id || "";

    return newData;
  }

  getTag() {
    const tag = document.createElement(this.currentLevel.tag);

    tag.innerHTML = this._data.text || "";

    tag.classList.add(this._CSS.wrapper);

    if (this._data.class !== "") {
      tag.classList.add(this._data.class);
    }
    tag.setAttribute("data-id", this._data.id);

    tag.contentEditable = this.readOnly ? "false" : "true";

    tag.dataset.placeholder = this.api.i18n.t(this._settings.placeholder || "");

    return tag;
  }
}
export default class extends Controller {
  static targets = ["html", "sidebar", "textContent", "saveBtn", "form"];
  connect() {
    console.log("EDitor OK !");

    // EditoJS Setup
    console.log();
    const data = this.textContentTarget?.dataset?.json;
    if (data) {
      const beforeInput = document.getElementById(
        "modification_content_before"
      );
      beforeInput.value = data;

      const editor = new EditorJS({
        /**
         * Create a holder for the Editor and pass its ID
         */
        holder: "editorjs",

        tools: {
          header: {
            class: CustomHeader,
            inlineToolbar: true,
          },
          list: {
            class: List,
            inlineToolbar: true,
          },
          text: {
            class: Text,
            inlineToolbar: true,
          },
          paragraph: {
            class: CustomParagraph,
          },
        },
        data: JSON.parse(data),
        onReady: () => {
          console.log("ready !");
          this.#update_titles();
        },
      });

      // Save button actions / animation
      console.log('FORM :',this.formTarget)
      const btn = this.saveBtnTarget;
      btn.addEventListener("click", (event) => {
        event.preventDefault();

        editor.save().then((savedData) => {
          console.log(JSON.stringify(savedData));
          const afterInput = document.getElementById(
            "modification_content_after"
          );
          afterInput.value = JSON.stringify(savedData);

          this.formTarget.submit();
        });
      });

      this.htmlTarget.addEventListener("mouseup", (event) => {
        event.preventDefault();
        this.saveBtnTarget.classList.add("active");
      });
    }
    // Sidebar
    const sidebar = document.getElementById("sidebar");
    const arrow = document.getElementById("sideArrow");

    if (sidebar) {
      arrow.addEventListener("click", (event) => {
        event.preventDefault();
        sidebar.classList.toggle("collapsed");
      });
    }
  }

  // Headers
  #update_titles() {
    const headersSidebar = document.querySelector("#list_titles");
    const h1sText = this.htmlTarget.getElementsByTagName("h1");

    // Permet d'afficher les titres H1 dans la sidebar
    console.log(h1sText);
    Array.from(h1sText).forEach((h1, index) => {
      h1.id = `header-${index}`;

      const btn = document.createElement("button");
      btn.setAttribute("id", `btn-${index}`);
      btn.classList.add("boutonSide");
      btn.innerText = h1.innerText;

      headersSidebar.appendChild(btn);

      btn.addEventListener("click", (event) => {
        const header = document.getElementById(`header-${index}`);
        header.scrollIntoView({
          behavior: "smooth",
        });
      });
    });
  }
}
