# Circles
Small app written in Swift 4 for a coding challenge EDIT: Updated to Swift 5

Release Notes:

Deployment target: iOS 11.0 +

A user can spawn an infinite number of circles by tapping on the main view. 
The newly created circle animates by scaling it's size. 
The circles sizes are calculated randomly between 40 - 100 px.
The circles are filled with random colors that are obtained by a http request from: www.colourlovers.com/api/colors/random?format=json.
If there is no network connection available or the request fails a random color is generated in code. 
A user can double tap a circle to change its color - color obtained by the above mentioned random color generator.
A user can move a circle around the view by tap and dragging it.
A user can pinch zoom to enlarge or shrink a circle.
A user can skake the divice to remove all circles in the view.
No third party libraries have been used.
