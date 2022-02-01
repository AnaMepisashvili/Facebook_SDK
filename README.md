# Facebook_SDK 

The App uses Facebook SDK, for this we need permissions and created Test User. 
To the fuctionality of the App you need to use users token and test user's token is updated sometimes.

If token has expired, you wont't be able to see the user's data, so you need to change the token. For this you need to contect to developer 
or use your test users token and paste it in the app Facebook/Core/FBToken/Constants and change the value of static let var token.

1. Login
- Login With Facebook 
- Comes from Facebook SDK
 
![login](https://user-images.githubusercontent.com/85555767/151987835-33ff589e-b521-439e-aa4a-f7265fc7df8b.gif)

Root - Tabbar View Controller
2. Home Feed
	- Display posts with pagination
	- Description, image, video

![home](https://user-images.githubusercontent.com/85555767/151987948-460bc922-1e97-4b51-a926-4660207092b7.gif)

  
3. List Of My Friends with all possible information
	- Fullname
	- imageUrl
	
  ![friends](https://user-images.githubusercontent.com/85555767/151988060-5c874b09-3238-44fe-b22d-6df4d4d59eed.gif)

4. Videos
	- Display videos from your facebook Feed SDK
	- created time, description, video 
	- If you tap play, video should start playing
	
  ![videos](https://user-images.githubusercontent.com/85555767/151988074-d5e4ff7d-4542-4e12-bfdb-5625b99ee6ad.gif)

5. Settings
	- Log Out
	- Display my avatar + full name
  
  ![logout](https://user-images.githubusercontent.com/85555767/151988053-3f3bfc27-c3d4-48e7-a77a-93e350457e40.gif)

# Build With 
- XCode 13.2.1
- Swift 5.5

# Architecture
- MVVM
