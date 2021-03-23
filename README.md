# Pre-work - *Tip Calculator*

**Tip Calculator** is a tip calculator application for iOS.

By: **Javier Garcia Ramirez**

Time spent: **12** hours spent in total

## User Stories

Features are implemented:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] User can select between tip percentages by tapping different values on the segmented control and the tip value is updated accordingly
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

* [X] Added a button to sort through different currencies.
* [X] Added dark mode switch and configured it with iPhone settings.
* [X] Added a Custom tip amount.
* [X] Added a % of tip that is compatible with the Custom feature.
* [X] Added a stepper to allow the user to split the bill.
* [X] Added app icon.

## My gifs
### Part 1: Bill Field, Currency Button, And Dark Mode Switch
<img src="https://media.giphy.com/media/ZGHbBjX87f5QIQHF6t/giphy.gif" width=250><br>
### Part 2: Segment Control, Custom Field, And Split The Bill
<img src="https://media.giphy.com/media/lPdV4dCdPU8M9yQZwL/giphy.gif" width=250><br>

## Notes

Challenges encountered while building the app.

* Setting dark mode feature and syncing it with dark more from iPhone setting.
* Dealing with constraits so the view is scaled to every device and orientation mode.
* Setting the button to change currency.
* Have a keyboard automatically launch when segment is placed on "Custom" and resigning the first responder.
* Using thousands separators and having the $ sign show up while editing.


## License

    Copyright [2020] [Javier Garcia Ramirez]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
