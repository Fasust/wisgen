# Wisgen 🔮
![last-commit badge](https://img.shields.io/github/last-commit/fasust/wisgen.svg?style=flat-square)
![contributors badge](https://img.shields.io/github/contributors/fasust/wisgen.svg?style=flat-square)
![wisdom badge](https://img.shields.io/badge/wisdom%20contributions-welcome-blueviolet?style=flat-square)
![fork badge](https://img.shields.io/github/forks/fasust/wisgen?label=Fork&style=social)
![star badge](https://img.shields.io/github/stars/fasust/wisgen?style=social)

A small Cross-Platform Wisdom Generator, built using [Flutter](https://flutter.dev/) and a combination of external APIs

This Wisdom Generator combines random advice from the the Internet with vaguely fitting and vaguely thought provoking stock images from the [Unsplash Source API](https://source.unsplash.com/). 
You can also save bits of wisdom you like in your _favorites_ or share them with your friends.



| ![Phone Mock of Wisdom Feed](https://github.com/Fasust/wisgen/blob/master/.additional_material/mock-feed-1.png) | ![Phone Mock of Wisdom Feed](https://github.com/Fasust/wisgen/blob/master/.additional_material/mock-feed-2.png) | ![Phone Mock of Wisdom Feed](https://github.com/Fasust/wisgen/blob/master/.additional_material/mock-feed-3.png) |
| -------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------: | -------------------------------------------------------------------------------------------------------------: |

## Where do I get the Wisdoms from?
- [Advice Slip API](https://api.adviceslip.com)
- [Advice from 100-Year-Olds](http://mentalfloss.com/article/54286/100-pieces-advice-100-year-olds)
- [InkTank](https://inktank.fi/28-of-the-best-pieces-of-advice-about-life-youll-ever-read/)
- [Life Hacks](https://www.lifehack.org/articles/lifestyle/50-life-lessons-that-people-arent-told-about.html)
- [Parent's Words of Wisdom](https://www.huffpost.com/entry/parents-words-of-wisdom_b_5598671)
- And a few Bits of my own Wisdom

### Wanna Contribute? 👪
You can suggest your own peaces of Wisdom a through Pull Request if you want. This is where all the [offline wisdoms](https://github.com/Fasust/wisgen/blob/master/assets/advice.txt) are saved. The "#" markes the beginning of new _type_ of Wisdom.

## Purpose of Wisgen
I used this project to understand how Flutter handles communication with the web and how it implements asynchronous calls. I also got the chance to better understand how Flutter handels _state_ and how to transfer that _state_ over multiple classes withing the Widget Tree.

## Download
[Android APK 📲](https://github.com/Fasust/wisgen/releases)

## BLoC Architecture: Dependencies of Wisgen Components
![Dependencies](https://github.com/Fasust/wisgen/blob/master/.additional_material/architecture/wisgen_depencies.PNG)

## BLoC Architecture: Dataflow of Wisgen Components
![Data Flow](https://github.com/Fasust/wisgen/blob/master/.additional_material/architecture/wisgen-dataflow.png)

 # Publications 🏆
Wisgen has been published as a reference project by:
- [Flutter Awesome](https://flutterawesome.com/a-cross-platform-wisdom-generator-built-with-flutter/)
- [Biblioteca Flutter](http://bibliotecaflutter.com.br/um-gerador-de-sabedoria-de-plataforma-cruzada-construido-com-flutter/)
- [Flutter App Dev](https://flutterappdev.com/2019/10/13/a-cross-platform-wisdom-generator-built-with-flutter/)

## Used Packages 📦
- flutter_bloc (for state handeling)
- http (for API calls)
- cached_network_image (for cashing images)
- flutter_launcher_icons (for easily setting the launcher icon)
- shared_preferences (for accessing shared preferences as offline storage)
- flutter_spinkit (loading animation)
- share (for sending _share-intents_)

## Used Tools 🛠
- [Draw.io for the diagramms](https://www.draw.io/)
- [JSON to Dart Generator to create POJO/DOJO classes](https://javiercbk.github.io/json_to_dart/)
 
## Some Sources I can recommend 📚
- [The Origin of the BLoC Pattern](https://www.youtube.com/watch?v=PLHln7wHgPE)
- [Implementing the BLoC Pattern](https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc/)
- [Infinite Lists with BLoC](https://felangel.github.io/bloc/#/flutterinfinitelisttutorial)
- [State handling in Flutter](https://www.youtube.com/watch?v=d_m5csmrf7I)
- [Naming Conventions](https://dart.dev/guides/language/effective-dart/style)
- [Code Readability](https://iirokrankka.com/2018/06/18/putting-build-methods-on-a-diet/)
