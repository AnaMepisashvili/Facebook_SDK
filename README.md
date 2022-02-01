# Facebook_SDK 

The App uses Facebook SDK, for this we need permissions and created Test User. 
To the fuctionality of the App you need to use users token and test user's token is updated sometimes.

If token has expired, you wont't be able to see the user's data, so you need to change the token. For this you need to contect to developer 
or use your test users token and paste it in the app Facebook/Core/Utilities/Strings and change the value of static let var token.

1. Login
	- Login With Facebook 
  - Comes from Facebook SDK
  
 ![Login](https://user-images.githubusercontent.com/85555767/151982188-32060ae4-cd7a-4370-aa27-4d5938b0c51b.gif)

Root - Tabbar View Controller
2. Home Feed
	- Display posts with pagination
	- Description, image, video
  
![home](https://user-images.githubusercontent.com/85555767/151984776-9dc839e1-4d8f-4345-b4cb-7cfa665aa9dd.gif)
  
3. List Of My Friends with all possible information
	- Fullname
	- imageUrl
  
![friends](https://user-images.githubusercontent.com/85555767/151985037-f273843c-2077-4600-bdba-c69d027fa6a9.gif)

4. Videos
	- Display videos from your facebook Feed SDK
	- created time, description, video 
	- If you tap play, video should start playing
  
![videos](https://user-images.githubusercontent.com/85555767/151985530-c43ba0e4-fd9f-4d61-9633-672958befe6b.gif)

5. Settings
	- Log Out
	- Display my avatar + full name
  
![logout](https://user-images.githubusercontent.com/85555767/151985870-5c4aab11-0c1d-4983-bac2-0bdb04044b7c.gif)

# Build With 
. XCode 13.2.1
. Swift 5.5

# Architecture
. MVVM
