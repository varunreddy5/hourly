import { Controller } from 'stimulus';
export default class extends Controller {
  static targets = ['form'];
  // connect() {
  //   this.outputTarget.textContent = 'Hello Stimulus!';
  // }
  show(event) {
    event.preventDefault();
    this.formTarget.classList.toggle('d-none');
  }
}
