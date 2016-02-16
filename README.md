# Project 4 - *Tweeter*

**Tweeter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] User can pull to refresh.

The following **additional** features are implemented:

- [x] Custom App Icon and Launchscreen
- [x] Detail View for Tweets

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Retweet and Favorite POST methods
2. JSON serialization method changes in Swift

## Video Walkthrough

![Tweeter](https://cloud.githubusercontent.com/assets/6467543/12879701/5ae1776e-ce05-11e5-901d-3ab3e6825cc5.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I could not get the POST methods for the retweet and favorite endpoints to work. They would simply crash the app and throw an error saying that the TimelineViewController has no such selection for the button. I even asked some classmates about ways to solve this and they could not suggest me anything that would work.

I have submitted a pull request featuring the issue, I hope to finish it soon.

## License

    Copyright [2016] [R. Alex Clark]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

* * *

# Project 5 - *Tweeter v2*

Time spent: **9** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] Profile page:
   - [x] Contains the user header view
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [x] Home Timeline: Tapping on a user image should bring up that user's profile page
- [x] Compose Page: User can compose a new tweet by tapping on a compose button.

The following **optional** features are implemented:

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Profile Page
   - [ ] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

The following **additional** features are implemented:

- [x] Custom UI and App Icons

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Setting up the TwitterClient was still something I hope we cover more in out
   sessions
2. I don't really understand how the new Swift API callbacks work or the
   completion functions work, I had to get some help with those

## Video Walkthrough

![Tweeter v2](https://cloud.githubusercontent.com/assets/6467543/13068592/d7e17cdc-d44a-11e5-9172-f4556013a392.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

This was a really fun application to build and I am glad that we got more time working with the API calls and functions. I was a little bit busy this week so I had to take an extra day to build this but it came together pretty well in the end.

## License

    Copyright [2016] [R. Alex Clark]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
