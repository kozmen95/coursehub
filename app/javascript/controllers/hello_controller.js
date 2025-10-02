import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Stimulus działa! 🎉")
    this.element.textContent = "👋 Hello from Stimulus"
  }
}
