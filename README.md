# Mathe Genius

An mathematics learning application built with Flutter that helps users master multiplication tables and math quizzes through interactive, gamified learning experiences.

## 🎯 Features

- **Home Screen** - Home screen
- <img width="300" height="1000" alt="Screenshot 2026-04-06 at 10 18 47 PM" src="https://github.com/user-attachments/assets/83a1380c-db2b-4d8f-bc43-23c25b56a71e" />

- **Quiz Mode** - Test your math skills with customizable quizzes
- <img width="300" height="1000" alt="Screenshot 2026-04-06 at 10 19 21 PM" src="https://github.com/user-attachments/assets/ea3bd431-5416-49b4-9839-8d98bdd41291" />

- **Timer Quiz** - Challenge yourself with time-limited quizzes
- **Table Battle** - Competitive mode to master multiplication tables
 
- **Daily Challenges** - Fresh math challenges every day
- <img width="300" height="1000" alt="Screenshot 2026-04-06 at 10 19 42 PM" src="https://github.com/user-attachments/assets/a8404cf4-2a3e-42c3-9dfe-f2c4ae5af4d9" />

- **Learn Tables** - Structured lessons for learning multiplication tables
- 
   <img width="300" height="1000" alt="Screenshot_1770696262" src="https://github.com/user-attachments/assets/cda5861a-aada-41d8-b3e3-d1b1cc459435" />
<img width="300" height="1000" alt="Screenshot 2026-04-06 at 10 20 23 PM" src="https://github.com/user-attachments/assets/00ba771a-9ff5-4878-8b69-4c2a5d2c3c45" />

   
- **Progress Tracking** - Monitor your learning progress over time
- <img width="300" height="1000" alt="Screenshot 2026-04-06 at 10 20 47 PM" src="https://github.com/user-attachments/assets/7f1cd85a-638a-4ab7-995a-cae1a98b9c47" />

- **Favorites** - Save and practice your favorite problems
- 
<img width="300" height="1000" alt="Screenshot 2026-04-06 at 10 21 09 PM" src="https://github.com/user-attachments/assets/4282f451-64b4-4d59-87ba-ddf3730fcc86" />

- **Settings** - Customize app experience and preferences
- <img width="300" height="1000" alt="Screenshot 2026-04-06 at 10 21 32 PM" src="https://github.com/user-attachments/assets/38b8d93a-47d7-456f-9751-eb53cd285512" />

- **Animations** - Engaging Lottie animations for better UX
- **Text-to-Speech** - Audio support for better accessibility

## 📱 Screenshots

The app features an intuitive welcome screen and splash screen with engaging animations to welcome users into the learning experience.

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **Platform**: Android & iOS
- **Audio**: flutter_tts (Text-to-Speech)
- **Audio Playback**: audioplayers
- **File Management**: path_provider
- **Animations**: Lottie JSON animations
- **Architecture**: Feature-based modular structure

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   └── custom_widgets/          # Reusable UI components
├── features/
│   ├── basic_math/              # Basic math operations
│   ├── daily_challenge_screens/  # Daily challenge features
│   ├── favourite_screens/        # Favorite problems
│   ├── home_screens/            # Home screen UI
│   ├── learn_table/             # Table learning lessons
│   ├── levels_quiz_screen/      # Level-based quizzes
│   ├── progress_screens/        # Progress tracking
│   ├── quiz_mode/               # Quiz functionality
│   ├── setting_screens/         # App settings
│   ├── table_battle_screen/     # Competitive mode
│   └── timer_quiz_screen/       # Timed quizzes
├── navigation_screens/
│   ├── controller/              # Navigation logic
│   └── views/                   # Navigation UI
└── welcome_screen/              # Splash & welcome screens

assets/
├── images/                      # Image assets
└── lottie/                      # Lottie JSON animations
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK
- Android Studio or Xcode (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ShamsulHaque12/Mathe_Genius.git
   cd mathe_genius
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build APK

```bash
flutter build apk --release
```

### Build iOS

```bash
flutter build ios --release
```
## Buid APK File
App link: https://drive.google.com/file/d/1TOBpgjO633h3Vq3a7kjp09KncKU7ypn7/view?usp=sharing  

Video link: https://app.usebubbles.com/2LUVqagFqdAxJQTx9nLtQX/recording-apr-06-2026

## 📦 Dependencies

Key packages used in this project:

- **flutter_tts**: Text-to-speech functionality
- **audioplayers**: Audio playback
- **path_provider**: File system access
- **lottie**: Beautiful animations

View `pubspec.yaml` for complete dependency list.

## 🎮 Usage

1. **Launch the app** - Start with the welcome screen
2. **Choose a mode** - Select from Quiz, Timer Quiz, Table Battle, or Daily Challenge
3. **Practice** - Complete the math challenges
4. **Track Progress** - View your improvement in the progress section
5. **Customize** - Adjust settings as needed

## 🔧 Development

### Project Configuration

- **Min SDK**: Check `android/app/build.gradle.kts`
- **iOS Deployment**: Check `ios/Podfile`
- **Analysis Options**: See `analysis_options.yaml`

### Running Tests

```bash
flutter test
```

## 📈 Features Roadmap

- [ ] Leaderboard system
- [ ] Social sharing features
- [ ] Offline mode enhancement
- [ ] Advanced analytics

## 🐛 Troubleshooting

**Build Issues**
- Run `flutter clean` and `flutter pub get`
- Check Android SDK version compatibility
- For iOS, run `pod install` in the ios directory

**Runtime Issues**
- Clear app cache and data
- Reinstall the app
- Check Flutter and Dart versions

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👥 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b main/sujon`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin main/sujon`)
5. Open a Pull Request

## 📞 Support

For issues, questions, or suggestions, please create an issue in the repository or contact the development team.

## 🙏 Acknowledgments

- Flutter and Dart communities
- Contributors and testers
- All users learning with Mathe Genius
