import { Controller } from "@hotwired/stimulus"
import { leave, toggle } from "el-transition"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    // Ensure the menu is hidden when the page loads
    leave(this.menuTarget)
  }

  toggle() {
    toggle(this.menuTarget)
  }

  hide(event) {
    const buttonClicked = this.buttonTarget.contains(event.target)

    if (!buttonClicked) {
      leave(this.menuTarget)
    }
  }
}
