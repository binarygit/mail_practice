# How to measure the Total Network Response Time using Stimulus

## Problem
You are building a website using Hotwire. Many parts of your application utilize Turbo and StimulusJs to provide a SPA like feel. However, in certain pages, the Turbo Actions feel slow. Maybe you're rendering a flash message after login or adding a new book to a list of books right after it's created on the same page...but it's slow. The view does update without a reload but there's a lag to the update.
The problem could be that it's taking your controller action which is responsible for rendering the page, a long time to respond and update the view. In other words, your page updates are slow because your Total Network Response Time is high.

![ezgif com-gif-maker(2)](https://user-images.githubusercontent.com/87677429/185598771-c19f8262-2a0c-46fd-a29f-5b8f15fd6364.gif)

Inorder to test this theory, you decide to create a feature that measures the total time it takes your controller action to respond to a request. 

How do you create such a feature that sends a request to the controller and calculates the time it takes the controller to respond?

## Solution
First, we need a button. When we click it the request is made and the total time taken is displayed. We also need a `paragraph` element to display the total time once it's calculated. Lastly we need to pass in the `url` of the current_page to our stimulus controller.

```html
<section 
  data-controller="network-test"
  data-network-test-url-value=<%= books_url %> >

  <button data-action="network-test#test">Press me!</button>
  <p data-network-test-target="message"></p>

</section>
```

Now, the steps for calculating the time that our server takes to respond to a request are very simple. They are:

1. Store a timestamp just before sending the request. We'll call this startTime.
2. Make the request.
3. Store another timestamp right after the response data is parsed. We'll call this endTime.
4. Calculate the difference between endTime and startTime. This is the total time our controller took to respond to our response. It's also called the Total Network Response Time.
5. Display the Total Network Response Time.

Here is the full StimulusCode:

```js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ["message"]

  async test() {
    const startTime = new Date()

    const response = await fetch(this.urlValue + '.json')
    const result = await response.json()

    const endTime = new Date()

    this.messageTarget.textContent = `Operation took ${endTime.getTime() - startTime.getTime()} msec`
  }
}
```

One thing to keep in mind with this approach is that we're expecting the data that the server gives us to be `json`.

```js
// The .json in the end lets the server know
// we are expecting a json response
const response = await fetch(this.urlValue + '.json')
const result = await response.json()
```

So, we'll need to tell our controller to respond with a json response.

```ruby
    respond_to do |format|
      ...
      ...
      format.json { render :json => @book }
    end

```

And here is how the feature looks like once it's done:

![ezgif com-gif-maker(3)](https://user-images.githubusercontent.com/87677429/185729996-1d5bab01-9bea-4e04-ac51-4882164ab986.gif)


