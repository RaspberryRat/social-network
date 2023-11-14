import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['fileField', 'formSubmit']

  filePicked() {
    const fileInput = this.fileFieldTarget;

    if (fileInput.files.length > 0) {
      console.log("Files selected:", fileInput.files);
      // Perform actions based on the selected files
      // You can check for changes in the selected file(s) here
      // For example, you can compare with the previous state if needed
    } else {
      console.log("No files selected");
    }
  }


}
