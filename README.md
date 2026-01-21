# My iOS App - Flutter Project

A Flutter application with iOS support, developed on Windows using a hybrid approach.

## Development Workflow (Hybrid Approach)

Since iOS apps require macOS to build, this project uses a hybrid workflow:

- **Development**: Write code on Windows in Cursor IDE
- **Local Testing**: Test using Chrome (Web) or Android emulator
- **iOS Builds**: Use Codemagic cloud service for iOS compilation
- **iPhone Testing**: Deploy to TestFlight for testing on physical device

## Quick Start

### Local Development on Windows

1. **Run on Web (Fastest for testing)**
   ```powershell
   flutter run -d chrome
   ```

2. **Run on Android (if emulator/device available)**
   ```powershell
   flutter run -d android
   ```

3. **Hot Reload**
   - Press `r` in terminal to hot reload
   - Press `R` to hot restart
   - Press `q` to quit

### Testing Changes Locally

You can develop and test 95% of features using the web version:

```powershell
cd C:\Users\bharat.patidar\Desktop\flutter\my_ios_app
flutter run -d chrome
```

## iOS Build Setup (Cloud-Based)

### Prerequisites

1. **Apple ID** (Free)
   - Create at [appleid.apple.com](https://appleid.apple.com)
   
2. **Codemagic Account** (Free tier available)
   - Sign up at [codemagic.io](https://codemagic.io)
   - Free tier includes 500 build minutes/month

3. **iPhone UDID**
   - Connect iPhone to PC
   - Use iTunes or 3uTools to find UDID
   - Format: `00008030-XXXXXXXXXXXX`

### Step-by-Step iOS Setup

#### 1. Create Git Repository

```powershell
git add .
git commit -m "Initial commit"
```

Push to GitHub, GitLab, or Bitbucket:

```powershell
git remote add origin https://github.com/yourusername/my_ios_app.git
git branch -M main
git push -u origin main
```

#### 2. Connect Codemagic

1. Go to [app.codemagic.io](https://app.codemagic.io)
2. Click "Add application"
3. Connect your Git repository
4. Select this Flutter project

#### 3. Configure Code Signing

**Option A: Automatic (Recommended for beginners)**

1. In Codemagic, go to app settings
2. Navigate to "Code signing identities"
3. Click "iOS code signing"
4. Choose "Automatic code signing"
5. Enter your Apple ID and App-Specific Password
6. Codemagic will generate certificates automatically

**Option B: Manual**

1. Create App Store Connect API key:
   - Go to [App Store Connect](https://appstoreconnect.apple.com)
   - Users and Access → Keys
   - Create new key with "Developer" access
   - Download private key (.p8 file)
   
2. Add to Codemagic:
   - Add Issuer ID, Key ID, and Private Key as environment variables
   - Update `codemagic.yaml` with these values

#### 4. Add Device UDID

1. In Codemagic settings, go to "Distribution"
2. Add your iPhone UDID under "iOS devices"
3. This allows ad-hoc builds to run on your phone

#### 5. Configure codemagic.yaml

Update these values in `codemagic.yaml`:

```yaml
vars:
  BUNDLE_ID: "com.yourcompany.myIosApp"  # Change this
  
publishing:
  email:
    recipients:
      - your.email@example.com  # Change this
```

#### 6. Trigger First Build

```powershell
git add .
git commit -m "Configure iOS build"
git push origin main
```

Codemagic will automatically start building!

## Daily Development Workflow

### 1. Write Code (Windows)

```powershell
# Navigate to project
cd C:\Users\bharat.patidar\Desktop\flutter\my_ios_app

# Start web server for testing
flutter run -d chrome
```

### 2. Test Locally

- Make changes in `lib/main.dart`
- Press `r` for hot reload to see changes instantly
- Test functionality in Chrome

### 3. Deploy to iPhone (When Ready)

```powershell
# Commit your changes
git add .
git commit -m "Add new feature"
git push origin main
```

Codemagic will:
- Detect the push
- Build iOS app (5-10 minutes)
- Upload to TestFlight (if configured)
- Email you when done

### 4. Test on iPhone

1. Install **TestFlight** app from App Store
2. Accept invitation email from TestFlight
3. Download your app in TestFlight
4. Test on your iPhone!

## Project Structure

```
my_ios_app/
├── lib/
│   └── main.dart           # Main app code (start here!)
├── ios/                    # iOS-specific files
├── android/                # Android-specific files
├── web/                    # Web-specific files
├── test/                   # Unit tests
├── pubspec.yaml           # Dependencies
├── codemagic.yaml         # CI/CD configuration
└── README.md              # This file
```

## Common Commands

```powershell
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Build Android APK
flutter build apk

# Check for issues
flutter doctor

# Run tests
flutter test

# Format code
flutter format .

# Analyze code
flutter analyze
```

## Troubleshooting

### "No device found"

```powershell
# Check available devices
flutter devices

# Run on Chrome specifically
flutter run -d chrome
```

### "Flutter command not found"

Make sure Flutter is in your PATH. Restart terminal after installation.

### iOS Build Fails on Codemagic

1. Check Codemagic build logs
2. Verify code signing is configured
3. Ensure UDID is added for ad-hoc builds
4. Check if Apple ID/password is correct

### Can't Install on iPhone

- Ensure your iPhone UDID is registered in provisioning profile
- Check TestFlight invitation was accepted
- Verify app is uploaded to TestFlight successfully

## Cost Breakdown

| Service | Cost | Notes |
|---------|------|-------|
| Flutter | Free | Open source |
| Cursor IDE | Free/Paid | Your choice |
| Apple ID | Free | For testing only |
| Apple Developer (paid) | $99/year | Only needed for App Store |
| Codemagic | Free tier | 500 min/month (enough for development) |
| TestFlight | Free | Included with Apple ID |

**Total for development: $0** (using free tiers)

## Next Steps

1. ✅ Project created
2. ✅ Git initialized
3. ⏳ Push to GitHub/GitLab
4. ⏳ Set up Codemagic
5. ⏳ Configure code signing
6. ⏳ Test first build
7. ⏳ Install on iPhone via TestFlight

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Codemagic Flutter Guide](https://docs.codemagic.io/flutter/)
- [TestFlight Setup](https://developer.apple.com/testflight/)
- [Apple Developer Portal](https://developer.apple.com/)

## Support

Need help? Check:
- Flutter Discord
- Stack Overflow (tag: flutter)
- Codemagic Support Chat

---

**Happy Coding! 🚀**
