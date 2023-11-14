import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['fileField', 'form']

  connect() {
    // const uploadFileField = document.getElementById('user_profile_picture')
    // statement(uploadFileField)
    console.log(`length of ${this.fileFieldTarget.files.length}`)

  }

  filepicked() {
    if (this.fileFieldTarget.files.length > 0) {
      this.uploadFile();
    } else {
      console.log('nothing chosen');
    }
  }

  uploadFile() {
    this.formTarget.submit();
  }
}
