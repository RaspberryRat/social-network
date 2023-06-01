import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['postTime']

  connect() {
    const localTime = this.convertToLocalTime(this.postTimeTarget.textContent)

    const formattedTime = this.formatTime(localTime)
    this.postTimeTarget.textContent = `${formattedTime}`;
  }

  convertToLocalTime(time) {
    return new Date(time)

  }

  formatTime(time) {
    const month = this.convertToMonthName(time.getMonth())
    const day = time.getDate()
    const hours = time.getHours()
    const minutes = time.getMinutes()
    const amPm = hours >= 12 ? 'PM' : 'AM'
    const formattedHours = hours % 12 || 12
    const formattedMinutes = minutes.toString().padStart(2, '0')

    return `${month} ${day} at ${formattedHours}:${formattedMinutes} ${amPm}`
  }

  convertToMonthName(number) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

    return months[number]
  }
}
