# Mathe Genius

An mathematics learning application built with Flutter that helps users master multiplication tables and math quizzes through interactive, gamified learning experiences.

## 🎯 Features

- **Home Screen** - Home screen
- 
  <img width="300" height="1000" alt="Screenshot_1770696244" src="https://github.com/user-attachments/assets/e8321d00-db75-4b08-be56-4291399214f2" />

- **Quiz Mode** - Test your math skills with customizable quizzes
- 
  <img width="300" height="1000" alt="Screenshot_1770696257" src="https://github.com/user-attachments/assets/cf6e1644-22af-4db2-a011-3f58a9904f90" />

- **Timer Quiz** - Challenge yourself with time-limited quizzes
- **Table Battle** - Competitive mode to master multiplication tables
 
- **Daily Challenges** - Fresh math challenges every day
- 
  <img width="300" height="1000" alt="Screenshot_1770696271" src="https://github.com/user-attachments/assets/83dc1741-6cf1-4cf0-be2f-2095938ffd78" />

- **Learn Tables** - Structured lessons for learning multiplication tables
- 
   <img width="300" height="1000" alt="Screenshot_1770696262" src="https://github.com/user-attachments/assets/cda5861a-aada-41d8-b3e3-d1b1cc459435" />
   <img width="300" height="1000" alt="Screenshot_1770696311" src="https://github.com/user-attachments/assets/e942d8ec-5f23-44c4-a3f1-cbcc015519a1" />

   
- **Progress Tracking** - Monitor your learning progress over time
- 
   <img width="300" height="1000" alt="Screenshot_1770696252" src="https://github.com/user-attachments/assets/f235c280-cd8b-4ef0-8b59-214078b45ad4" />

- **Favorites** - Save and practice your favorite problems
- 
  <img width="300" height="1000" alt="Screenshot_1770696279" src="https://github.com/user-attachments/assets/78ab7e06-6093-4cf2-b6b5-5d01aa641dac" />

- **Settings** - Customize app experience and preferences
- 
  <img width="300" height="1000" alt="Screenshot_1770696284" src="https://github.com/user-attachments/assets/ce6ab495-be6c-4af6-ab29-1e4d6429b386" />

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
App link: https://drive.google.com/file/d/1Ty8XhMWUv1jkh_9JB1kZcXbln-69MV-m/view?usp=sharing

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
