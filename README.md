# FayInterview

## Overview video
Sending in email because i've downgraded the quality and still can't get it below the 10MB github requires

## Comments
- Saved JWT token to keychain to keep it secure. Normally you get a refresh token or something but I don't have an endpoint for that so I'm just observing if we ever get a 401 to navigate the user back to auth.
- Some things are overkill, but I would build this with the assumption i'm going to keep building on it so I would set up all of the boiler plate code and make components re-usable.
- Used MVVM with Coordinator pattern for navigation
- I would taken the appointments view further if the appointments endpoint was paged to handle that scenario

## Time Spend
- Setup - I spent most of the time just setting up boiler plate code and adding components I knew I needed and making them reusable. 
- Login - 2 hours approximately to setup the UI and the logic
- Appointments List - 3 hours approximately setting up UI and logic. I ran into an issue trying to get the date calendar component month and date area width to equal eachother which took longer than expected. 
