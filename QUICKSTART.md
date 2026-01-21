# Quick Start Guide

## Test Your App Right Now!

### Option 1: Run in Chrome (Recommended)

Open a terminal and run:

```powershell
cd C:\Users\bharat.patidar\Desktop\flutter\my_ios_app
flutter run -d chrome
```

This will:
- Open Chrome automatically
- Show the Flutter counter demo app
- Enable hot reload (press `r` to reload after changes)

### Option 2: Run in Edge

```powershell
flutter run -d edge
```

### Option 3: Run as Windows Desktop App

```powershell
flutter run -d windows
```

## What You'll See

The default app is a simple counter that increments when you tap the + button.

## Try Making Changes

1. **Run the app** in Chrome (using command above)
2. **Open** `lib/main.dart` in Cursor
3. **Find** line 10: `title: 'Flutter Demo'`
4. **Change** to: `title: 'My iOS App'`
5. **Save** the file
6. **In terminal**, press `r` to hot reload
7. **Watch** the title update instantly! 🎉

## Next Steps

1. ✅ Test app locally in Chrome
2. ⏳ Push code to Git repository
3. ⏳ Set up Codemagic account
4. ⏳ Configure iOS code signing
5. ⏳ Deploy to your iPhone via TestFlight

See [README.md](README.md) for complete setup instructions.

## Commands Reference

| Command | What it does |
|---------|--------------|
| `flutter run -d chrome` | Run in Chrome |
| `flutter run -d edge` | Run in Edge |
| `flutter run -d windows` | Run as Windows app |
| `flutter devices` | List available devices |
| `flutter doctor` | Check setup |
| Press `r` | Hot reload (in running app) |
| Press `R` | Hot restart |
| Press `q` | Quit app |

## Troubleshooting

**"Target of URI doesn't exist"**
- Make sure you're in the correct directory
- Run `flutter pub get` to install dependencies

**Chrome doesn't open**
- Close any existing Flutter Chrome windows
- Try `flutter run -d edge` instead

**"No devices found"**
- Run `flutter devices` to see available options
- Ensure Chrome or Edge is installed

---

Need help? Check the main [README.md](README.md) for detailed documentation.
