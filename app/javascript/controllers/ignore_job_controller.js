import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['ignoreButton']

  hideJob(e) {
    e.preventDefault()
    let jobMessage = document.getElementsByClassName('job-count')[0]
    let jobCount = jobMessage.innerText.split(' ')[0] - 1
    let jobTotal = jobMessage.innerText.split(' ')[5]
    e.currentTarget.parentNode.parentNode.parentNode.remove()
    jobMessage.innerText = `${jobCount} jobs displayed out of ${jobTotal} jobs posted this week`
  }
}
