# Offline_MovieDB
Source code for a minimalistic Flutter application that stores a user-created movie watchlist on local storage.  
The app stores movie details such as the name, director name, thumbnail and displays it with the help of a ListView.   
Persistent Google Sign-in is enabled, the database will be right where you left it, the next time you start the app. You won't be logged out automatically.  
The database stores the local thumbnail path instead of storing the image itself. In the listView, image retrieved from the stored path is then displayed.  

Users can add new movies, update existing details including the thumbnail and delete movies from the database.  
Users can also select if they have watched the movie already using the provided switch and a green checkbox will appear at the bottom left of the thumbnail. This attribute can also be updated.  
Assets folder has been added to .gitignore  

Here are some screenshots of the app:  
Sign In Screen  
![image](https://user-images.githubusercontent.com/48710616/129595620-eb714712-4943-45ed-b795-17b407d46671.png)  

Initial Log In Screen  
![image](https://user-images.githubusercontent.com/48710616/129595378-0be4dba8-a8b8-4367-9569-727ea30133ec.png)  

AddMovie Popup  
![image](https://user-images.githubusercontent.com/48710616/129595751-3a2276df-a4c5-4460-af67-ccbf991cd826.png)  

AddMovie Popup Validation  
![image](https://user-images.githubusercontent.com/48710616/129595839-095ac37d-095f-4a12-954e-59f3bfd7594b.png)  

ListView Preview  
![image](https://user-images.githubusercontent.com/48710616/129595980-7700ac9a-789a-4040-9579-55e73b7a215d.png)  

ListView End  
![image](https://user-images.githubusercontent.com/48710616/129596126-1344191f-8194-4b8f-8de1-2d34ad645e04.png)  

Update Movies Popup  
![image](https://user-images.githubusercontent.com/48710616/129596281-0d7b1fe2-d28e-4be2-b20d-54f502600e49.png)  

Update Popup Validation  
![image](https://user-images.githubusercontent.com/48710616/129596374-14605264-9883-444b-96d4-567fc71cc16f.png)  

Delete Movie Popup  
![image](https://user-images.githubusercontent.com/48710616/129596659-e863d97d-cc23-4e65-886b-d8b4ba38065f.png)





