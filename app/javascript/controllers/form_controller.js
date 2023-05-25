import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['contentField'];

  reset() {
    this.contentFieldTarget.value = '';
  }
}
