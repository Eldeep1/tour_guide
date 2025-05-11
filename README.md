# tour_guide

## didn't done yet:
1. ~~adding scrolling controller~~
2. ~~lottie animation~~
3. navigation animations
4. user settings?
5. ~~white theme~~
6. ~~theme transition button~~
7. ~~splash screen~~
8. no internet page
9. ~~logout button~~
10. ~~messages shouldn't divide the page horizontally~~
11. ~~hide passwords when bing written and add eye icon~~
12. ~~changing the text form field height~~
13. ~~changing the text form field icons!~~
14. ~~add validation on login, register and chat page!~~
15. what about iphone?
16. delete the form fields when navigating to another pages?
17. remove circular progress indicator of login
    - login button
    - register button
    - loading messages page
    - is it possible for loading the model page?
18. sending message animation
19. receiving message animation
20. removing the amber colored buttons from the object detection page
21. shimmer effect when loading messages
22. unfocus when send a message
23. save white theme on local storage
24. start with the system default theme
25. solve the technical dept on the theme file (should use interface instead of directly shared preferences)

added white theme to storage
added default light theme
fixed login bugs
## notes:
- will dio request headers change over time? ّّ
- multi threading in dio network requests?
- think that chat headers provider is uselss
- - what about adding analytics?
- when logout, we are simply deleting the token from the storage and call the endpoint
    - what if the end point returned bad response?