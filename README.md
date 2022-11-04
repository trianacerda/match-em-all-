#  Match 'Em All-- Triana Cerda

#### Video Demo: https://www.youtube.com/watch?v=_vyBlLXrBVc

#### Description:
An app built for me and my family with someone special in mind. I wanted to build something that would remind me of happiness and fun all while testing out my memory. This app is a matching game utilitzing apple's iconic emojis and personally picked by me. It's a demonstration of inside jokes, funny stories, and unforgetable memories-- all within emojis. Whatever emojis remind you of all the better things in life, they can be built into an app you can use on your iOS device of choice. 

The ground work was built in the planning of the app and finding .png images that didn't have an unwanted white background image. It was fairly difficult to find the correct images needed to keep the app consitent and looking nice. It wasn't until the final stages I was able to solidify a nice looking group of emojis. 

A structural piece of the app consists for a CardCollectionViewCell that houses all the functionality and view of the cards rendered. This is where the transitions are created when the card is flipped + how long a card or match will be viewed. Along with the transitions, there is a function that targets the image of the card and rounds the edges

Another important structural piece of the app is the ViewController which is what the user interacts with and sees. This is where the logic for the app lives and will repsond based on a user's choice. This file uses the SoundManager and Card classes to respond based on a user's selection. The file is where I spent a lot of time since this app is built to respond to events. I added a few extra sounds so basically, at all times the app is making some noise.  

Some difficulties I ran into were indentifying the correct array needed to display the card. There were two seperate arrays, a random numbers array and a cards array. The cards were displayed and changed based on the random number. My naming conventions that were helpful were "card1" and "card4". I would target the number and that is what would change each instance of the game. A huge road block I encountered was working with contraints. Just being able to target the correct area, image, or section felt "easy" but working with their contraints was tough. When a constraint was added, it didn't leave-- it was just overwritten but stayed put. At one point I have put so many constraints that I need to "hard reset" and start over. 

I learned a lot in the making of this app. Some of the moments that stood out were the actually flipping of the cards. Seeing the transition from the front/back view was very exciting. Another very cool part was interacting with the nib. Being able to drag and interactive with the UI + inject code into files was new to me. 

The files included with this app are:
-CS50 Final
    -Sounds
        -flip.mp3
        -lost.mp3
        -match.mp3
        -nomatch.mp3
        -shuffle.mp3
        -win.mp3
    -AppDelegate
    -SceneDelegate
    -ViewController
    -CardModel
    -Card
    -CardCollectionViewCell
    -Main
    -Assests
        -back(background)
        -card1-14(emoji)
    -LaunchScreen
    -Info
    -SoundManager
    -README
-Products
-Frameworks
    
        
# And that my friends, was CS50!

