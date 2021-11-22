Original App Design Project
===

# Depression Brook (not official name)

## Table of Contents
0. [Gifs of Progress](#Progress)
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Progress
- **Sprint 2**
![](https://i.imgur.com/DngpOPt.gif)

## Overview
### Description
Allows individuals at Stony Brook to write posts about their day and interests like a diary, with comments. Mainly geared towards improving the mental health of students. Has a chat function so that students can message one another.

### App Evaluation
- **Category:** Social Networking/ Lifestyle
- **Mobile:** This will be mainly a mobile app but would be viable on a computer as well, like most jouraling and social networking apps. 
- **Story:** Allows students to write posts that can be either private or public. User can then decide to message the user for moral support or even message to meet up in person. 
- **Market:** Made for Stony Brook University students, and try to keep it a safe environment. 
- **Habit:** The post function can be used as often as students want to log how their day went, or for students wanting to meet up. The chat function is not designed for a long term message platform. 
- **Scope:** First we would start having only SBU students be able to write posts, then perhaps this could evolve into a platform for other universities. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User stays logged in across restarts.
- [x] User can log out.
- [x] User can view comments on a post.
- [x] User can add a new comment.
- [] User can add a profile picture.
- [] Profile pictures are shown for posts and comments.
----
- [x] User sees app icon in home screen and styled launch screen.
- [x] User can sign up to create a new account.
- [x] User can log in.
- [x] User can write a post, and post it to the server.
- [x] User can view the last 20 posts.
----
(Will update and add more stories in detail)
- [] User can mark posts as public or private
- [] User can see all messages
- [] User can message other users
- [] User can view profile picture in chat
- [] Using hashtags such as #meetup, #rant, #highlights, #whatididtoday to filter through posts

**Optional Nice-to-have Stories**

- [] The ability to join groups based on similaries such as year, major or hobbies. 
- [] User can load past photos infinitely.
- [] User can pull to refresh.

### 2. Screen Archetypes

* Login
* Register an account
   * The account will stay login after exiting and reentering the app
* Main Screen with posts
   * shows the daily posts of the users in chronological order
   * As you scroll the screen down, it will show older posts. 
* Previous message list screen
    * Shows all the previous chats
* Chat Screen
    * Chat the users of the daily posts that they want to chat with
* Profile page
    * Shows the information of the user
    * Could possibly show user posts

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Posts page
* Profile
* Messages list
* Chatting

**Flow Navigation** (Screen to Screen)
* Forced Log-in
    * Account creation if no log in is available
* Account creation
    * Create your profile
* Posts page
    * Write a new post
    * Profile of the author
* Profile of another user
    * Message the author of the post
* Profile of self
    * Settings page

## Wireframes
[Add picture of your hand sketched wireframes in this section]
![](https://i.imgur.com/2B0Hs19.png)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
**User**
| property     | type     | description                                 |
| ------------ | -------- | ------------------------------------------- |
| objectID     | String   | Unique id for the user post (default field) |
| username     | String   | User's username                             |
| password     | String   | User's password                             |
| profileImage | File     | Profile picture                             |
| name         | String   | User's name                                 |
| dob          | Date     | User's date of birth                        |
| bio          | String   | Introduction of user                        |
| email        | String   | User's email                                |
| updatedAt    | DateTime | Date when user last updated (default field) |
| createdAt    | DateTime | Date when user signed up (default field)    |


**Thread**
| property   | type               | description                                   |
| ---------- | ------------------ | --------------------------------------------- |
| objectID   | String             | Unique id for the user thread (default field) |
| author     | Pointer to User    | Author of the thread                          |
| hashtags   | Pointer to hashtag | Hashtags related to title                     |
| title      | String             | Title of thread                               |
| text       | String             | Body of thread                                |
| likesCount | Integer            | Number of likes                               |
| savedBy    | Array of Users     |                                               |
| comments   | Array of Strings   | Comments pointed to a thread                  |
| updatedAt  | DateTime           | Date when user last updated (default field)   |
| createdAt  | DateTime           | Date when user signed up (default field)      |

**Comment**
| property  | type              | description                                   |
| --------- | ----------------- | --------------------------------------------- |
| objectID  | String            | Unique id for the user thread (default field) |
| author    | Pointer to User   | Author of comment                             |
| thread    | Pointer to Thread | Thread comment belongs to                     |
| text      | String            | Comment on thread                             |
| updatedAt | DateTime          | Date when user last updated (default field)   |
| createdAt | DateTime          | Date when user signed up (default field)      |

**Hashtags**
| property  | type             | description                                   |
| --------- | ---------------- | --------------------------------------------- |
| objectID  | String           | Unique id for the user Thread (default field) |
| Threads   | Array of Threads | Threads related to a Hashtag                  |
| updatedAt | DateTime         | Date when user last updated (default field)   |
| createdAt | DateTime         | Date when user signed up (default field)      |

**Chat**
| property  | type     | description                                 |
| --------- | -------- | ------------------------------------------- |
| conversationId | String | Unique id for the user post (default field) |
|messages| Array | List of all Messages |
|Message| Array| Objects of each message |
| createdAt | DateTime | Date when user sent message |
| subscriber | PFObject |  |
| subscription | PFObject |  |
| message.body_text | String |  |
| message.sender_id| String |  |
| message.display_name | String |  |
| message.display_name | String |  |
| message.conversation_id | String |  |

```
 self.subscriber = Client(server: "ws://partygoer.org:8080/parse")
        self.subscription = subscriber.subscribe(conversation_query)
        self.subscription.handle(Event.created, { (query, object) in
            print("Item created")
            if let message = object as? Message {
                self.messages.append(message)
                DispatchQueue.main.async {
                    self.finishReceivingMessage(animated: true)
                }
            }
        })
```
```
       let message = Message()
        message.body_text = text
        message.sender_id = senderId
        message.display_name = senderDisplayName
        message.conversation_id = conversationId
```
### Networking
**List of Networking Requests by Screen**
- Login/Signup Screen
    - (Read/GET) Query User for valid username and password.
    - (Create/POST) Sign up user with new username and password.
    
- Main Screen
    - (Read/GET) Query title, author, and text for Threads with a recent createdAt time.
    - (Read/GET) Query title, author, and text for Threads with the highest likes.
    - (Read/GET) Query title, author, and text for Threads with the user listed in the savedBy array.
    - (Create/POST) Add a like to a thread.
    - (Delete) Remove a like from a thread.

- New Thread
    - (Create/POST) Create a Thread with title, hashtags, and text.
```
let thread = PFObject(className:"Thread")
thread["title"] = "Hi"
thread["text"] = "I'm bored"
thread["hashtags"] = "#yolo"
thread.saveInBackground { (succeeded, error)  in
    if (succeeded) {
        // Dismiss and refresh view controller
    } else {
        // There was a problem, check error.description
    }
}
```

- Selected Thread
    - (Read/GET) Query thread for title, author, text, and hashtags.
    - (Read/GET) Query author for author's profile picture.
    - (Read/GET) Query comments for text and authors.
    - (Create/POST) Add a like to a thread.
    - (Delete/POST) Remove a like from a thread.
    - (Create/POST) Add a comment to a thread.
- Profile Settings
    - (Read/GET) Query for current user's name, and DOB (if set).
    - (Update/PUT) Update name, date of birth, password, or profile picture.
- Profile Screen
    - (Read/GET) Query logged in user object
    - (Update/PUT) Update user profile image
- Other User Profile
    - (Read/GET) Query for author's username, profile picture, and bio.
- List of Chats Tab
    - (Read/GET) Query recipeient, and most recent message body with a recent createdAt time.
    - (GET) Query recipeient's profileImage
- Direct Chat
    - (Read/GET) Query recipeient's profileImage
    - (Create/POST) Create a new message object
    - (Read/GET) Query all previous messages


- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
