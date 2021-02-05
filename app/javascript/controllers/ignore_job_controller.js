import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["ignoreButton"]

  connect() {
    // this.delete = false
    // console.log("connected")
  }

  hideJob(e) {
    e.preventDefault()
    console.log("ignore button registered")
    // 3 parents
    // e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
    e.currentTarget.parentNode.parentNode.parentNode.remove()
    // this.element.removeChild(this.element.lastElementChild)
  }
}
