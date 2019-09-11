# Wisgen 🔮

A small Cross-Platform Wisdom Generato, built using [Flutter](https://flutter.dev/) and a combination of external APIs

This Wisdom Generator combines random advice from the the Internet with vaguely fitting and vaguely thought provoking stock images from the [Unsplash Source API](https://source.unsplash.com/). 
You can also save bits of Wisdom you like in your _Favorites_ or share them with your friends.



| ![Phone Mock of Wisdom Feed](https://github.com/Fasust/wisgen/blob/master/additional_material/mock-feed-3.png)    | ![Phone Mock of Wisdom Feed](https://github.com/Fasust/wisgen/blob/master/additional_material/mock-feed-2.png)  | ![Phone Mock of Wisdom Feed](https://github.com/Fasust/wisgen/blob/master/additional_material/mock-feed-1.png)  |
| ------------- |:-------------:| -----:|

### Where is the Advice from?
- [Advice Slip API](https://api.adviceslip.com) (Currently Broken)
- [Advice from 100-Year-Olds](http://mentalfloss.com/article/54286/100-pieces-advice-100-year-olds)
- [InkTank](https://inktank.fi/28-of-the-best-pieces-of-advice-about-life-youll-ever-read/)
- [Life Hacks](https://www.lifehack.org/articles/lifestyle/50-life-lessons-that-people-arent-told-about.html)

### Purpose
I used this project to understand how Flutter handles communication with the web and how it implements asynchronous calls. I also got the chance to better understand how Flutter handels _state_ and how to transfer that _state_ over multiple classes withing the Widget Tree.

### Download
[Android APK 📲](https://github.com/Fasust/wisgen/blob/master/app-release.apk)

### Used Packages
- provider (for state handeling)
- http (for API calls)
- cached_network_image (for cashing images)
- flutter_launcher_icons (for easily setting the launcher icon)
- shared_preferences (for accessing shared preferences as offline storage)
- share (for sending _share-intents_)
 
### Some Sources I can recommend 
- [State handling in Flutter](https://www.youtube.com/watch?v=d_m5csmrf7I)
- [Naming Conventions](https://dart.dev/guides/language/effective-dart/style)
- [Code Readability](https://iirokrankka.com/2018/06/18/putting-build-methods-on-a-diet/)
