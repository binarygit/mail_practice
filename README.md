# How to create a Network Tester with StimulusJs

## Problem
You are building a website using Hotwire. There are many parts of your application that utilize Turbo and stimulusJs to provide a SPA like feel. However, in certain pages, the Turbo Actions feel slow. Maybe you're rendering a flash message after login or adding a new book to a list of books right after it's created on the same page...but it's slow. The view does update without a reload but there's a lag to the update.
The Problem could be that it's taking your controller action which is responsible for rendering the page, some time to respond and update the view.

![ezgif com-gif-maker(2)](https://user-images.githubusercontent.com/87677429/185598771-c19f8262-2a0c-46fd-a29f-5b8f15fd6364.gif)

Inorder to test this theory, you decide to create a feature that measures the total time it takes your controller action to respond to a request.

How do you create such a feature that sends a request to the controller and calculates the time it took the controller to respond?

## Solution
Let's assume that we want to test the total time it takes for the `StaticPages#home` controller to provide a response to the view. We are going to initiate the response using a button. When the button is clicked, the response time is calculated and displayed in the page itself.

Here is our HTML

```html
<section 
  data-controller="network-test" 
  data-network-test-url-value=<%= home_url %> >

  <button data-action="network-test#test">Press me!</button>
  <div data-network-test-target="message"></div>

</section>
```

The steps for calculating the time that our server takes to respond to a response are very simple. We just need a Stimulus Controller to make a request when our `Press Me!` button is clicked and then display the time.  

1. Store a timestamp just before sending the request. We'll call this startTime.
2. Make the request.
3. Store another timestamp right after the response data is parsed. We'll call this endTime.
4. Calculate the difference between endTime and startTime. This is the total time it took our controller to respond to our response. It's also called the Total Network Response Time.
5. Display the Total Network Response Time.

Here is the full StimulusCode:

```js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ["message"]

  async test() {
    const startTime = new Date()

    const response = await fetch(this.urlValue)
    const result = await response.json()

    const endTime = new Date()

    this.messageTarget.textContent = `Operation took ${endTime.getTime() - startTime.getTime()} msec`
  }
}
```
