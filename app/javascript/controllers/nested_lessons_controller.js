import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["lessons", "template"]

  add(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.lessonsTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    event.preventDefault()
    let wrapper = event.target.closest(".lesson-fields")
    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove()
    } else {
      wrapper.style.display = "none"
      wrapper.querySelector("input[name*='_destroy']").value = 1
    }
  }
}
