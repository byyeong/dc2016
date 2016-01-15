
//Standard EventsAdd standard events to your code to track specific types of actions on your website. Copy the code for the type of event you want to measure, and paste it below the pixel code on the relevant page within a <script> tag. Learn more about conversion tracking.
// ViewContent
// Track key page views (ex: product page, landing page or article)
    fbq('track', 'ViewContent');


// Search
// Track searches on your website (ex. product searches)
fbq('track', 'Search');


// AddToCart
// Track when items are added to a shopping cart (ex. click/landing page on Add to Cart button)
fbq('track', 'AddToCart');


// AddToWishlist
// Track when items are added to a wishlist (ex. click/landing page on Add to Wishlist button)
fbq('track', 'AddToWishlist');


// InitiateCheckout
// Track when people enter the checkout flow (ex. click/landing page on checkout button)
fbq('track', 'InitiateCheckout');


// AddPaymentInfo
// Track when payment information is added in the checkout flow (ex. click/landing page on billing info)
fbq('track', 'AddPaymentInfo');


// Purchase
// Track purchases or checkout flow completions (ex. landing on "Thank You" or confirmation page)
fbq('track', 'Purchase', {value: '1.00', currency: 'USD'});


// Lead
// Track when a user expresses interest in your offering (ex. form submission, sign up for trial, landing on pricing page)
fbq('track', 'Lead');


// CompleteRegistration
// Track when a registration form is completed (ex. complete subscription, sign up for a service)
fbq('track', 'CompleteRegistration');

