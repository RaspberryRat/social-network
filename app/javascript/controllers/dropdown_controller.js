import { Controller } from "@hotwired/stimulus"
import { leave, toggle } from "el-transition"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "button", "overlay"]

  connect() {
    // Ensure the menu is hidden when the page loads
    leave(this.menuTarget)
  }

  toggle() {
    toggle(this.menuTarget)
    toggle(this.overlayTarget)
    this.menuTarget.classList.toggle("visible")
  }

  hide(event) {
    const buttonClicked = this.buttonTarget.contains(event.target)

    if (!buttonClicked) {
      leave(this.menuTarget)
      leave(this.overlayTargetTarget)
      this.menuTarget.classList.remove("visible")

    }
  }
}
