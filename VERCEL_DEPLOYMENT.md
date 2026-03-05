# 🚀 Deploy FlutterQuest to Vercel

## Prerequisites

1. ✅ Flutter SDK installed (you have this)
2. ✅ Git installed
3. ✅ Vercel account (free) - [Sign up here](https://vercel.com/signup)
4. ✅ GitHub account (optional but recommended)

## Method 1: Deploy via GitHub (Recommended)

### Step 1: Create GitHub Repository

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - FlutterQuest game"

# Create new repo on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/flutter-quest.git
git branch -M main
git push -u origin main
```

### Step 2: Connect to Vercel

1. Go to [vercel.com](https://vercel.com)
2. Click **"Add New Project"**
3. Click **"Import Git Repository"**
4. Select your **flutter-quest** repository
5. Configure:
   - **Framework Preset:** Other
   - **Build Command:** `flutter build web --release`
   - **Output Directory:** `build/web`
   - **Install Command:** Leave default or use custom Flutter setup
6. Click **"Deploy"**

### Step 3: Wait for Build

Vercel will:
- Install Flutter
- Run `flutter pub get`
- Build your web app
- Deploy to a URL like `your-project.vercel.app`

⏱️ First build takes ~5-10 minutes (installing Flutter)

## Method 2: Deploy via Vercel CLI (Faster)

### Step 1: Build Web Version Locally

```bash
# Navigate to your project
cd "c:\Users\VIVEK\OneDrive\Desktop\FLUTTER GAME\flutter_game"

# Build for web (production mode)
flutter build web --release

# This creates build/web/ directory
```

### Step 2: Install Vercel CLI

```powershell
# Install via npm
npm install -g vercel

# Or via yarn
yarn global add vercel
```

### Step 3: Deploy

```bash
# Login to Vercel
vercel login

# Deploy (from project root)
vercel

# Follow prompts:
# - Setup and deploy? Yes
# - Scope? Your account
# - Link to existing project? No
# - Project name? flutter-quest (or any name)
# - Directory? ./build/web
# - Override settings? No
```

### Step 4: Production Deployment

```bash
# Deploy to production
vercel --prod
```

## Method 3: Manual Upload (Simplest)

### Step 1: Build Web

```powershell
cd "c:\Users\VIVEK\OneDrive\Desktop\FLUTTER GAME\flutter_game"
flutter build web --release
```

### Step 2: Upload to Vercel Dashboard

1. Go to [vercel.com/new](https://vercel.com/new)
2. Click **"Deploy"** without Git
3. Drag and drop the **`build/web`** folder
4. Click **"Deploy"**
5. Done! ✅

## Configuration Files Already Added

I've created these files for you:

### 1. `vercel.json`
```json
{
  "buildCommand": "flutter build web --release",
  "outputDirectory": "build/web",
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

### 2. `.vercelignore`
Tells Vercel which files to ignore during deployment.

## Quick Deploy Command

```bash
# One-command deploy (after building locally)
cd "c:\Users\VIVEK\OneDrive\Desktop\FLUTTER GAME\flutter_game"
flutter build web --release && vercel --prod
```

## Troubleshooting

### Issue: "Flutter not found"
**Solution:** Use Method 3 (build locally, upload manually)

### Issue: "Build timeout"
**Solution:** 
- Build locally: `flutter build web --release`
- Deploy only the `build/web` folder
- Or upgrade Vercel plan for longer build times

### Issue: "Fonts not loading"
**Solution:** Already handled! Your `pubspec.yaml` includes Google Fonts.

### Issue: "Assets not found"
**Solution:** Run `flutter clean` then `flutter build web --release`

## Environment Variables (If needed)

Add in Vercel dashboard → Project Settings → Environment Variables:

```
FLUTTER_WEB=true
```

## Custom Domain (Optional)

1. Go to Project Settings → Domains
2. Add your custom domain
3. Update DNS records as instructed
4. Wait for propagation (~5 mins)

## Post-Deployment Checklist

After deployment, test:

- ✅ App loads correctly
- ✅ Navigation works
- ✅ Lesson screens display
- ✅ Example screens work
- ✅ Challenges function
- ✅ Results screen shows
- ✅ XP tracking works
- ✅ Progress saves (uses local storage)

## Recommended Settings for Production

### 1. Enable Web Optimizations

In `web/index.html`, ensure you have:
```html
<script>
  var serviceWorkerVersion = null;
  var scriptLoaded = false;
  
  // Service worker for offline support
  if ('serviceWorker' in navigator) {
    window.addEventListener('load', function () {
      navigator.serviceWorker.register('flutter_service_worker.js');
    });
  }
</script>
```

### 2. Optimize Build Size

```bash
# Build with tree shaking and minification
flutter build web --release --web-renderer canvaskit --tree-shake-icons
```

### 3. Enable Compression

Vercel automatically handles:
- ✅ Gzip compression
- ✅ Brotli compression
- ✅ CDN caching
- ✅ HTTPS

## Performance Tips

1. **Use CanvasKit renderer** (better performance):
   ```bash
   flutter build web --release --web-renderer canvaskit
   ```

2. **Or use HTML renderer** (smaller size):
   ```bash
   flutter build web --release --web-renderer html
   ```

3. **Auto-detect** (recommended):
   ```bash
   flutter build web --release --web-renderer auto
   ```

## Continuous Deployment

Once connected to GitHub, every push automatically deploys:

```bash
git add .
git commit -m "Update game"
git push

# Vercel automatically rebuilds and deploys! 🎉
```

## Your Deployment URLs

After deployment, you'll get:

- **Production:** `https://flutter-quest.vercel.app`
- **Preview:** `https://flutter-quest-git-main-yourname.vercel.app`
- **Each commit:** Unique preview URL

## Cost

- ✅ **FREE** for personal projects
- ✅ Unlimited deployments
- ✅ 100GB bandwidth/month
- ✅ Automatic HTTPS
- ✅ Global CDN

## Next Steps After Deployment

1. Share your game URL! 🎮
2. Add to your portfolio
3. Get feedback from users
4. Monitor with Vercel Analytics (optional)

## Support

Need help? Check:
- [Vercel Docs](https://vercel.com/docs)
- [Flutter Web Docs](https://docs.flutter.dev/platform-integration/web)
- [Vercel Discord](https://vercel.com/discord)

---

**Ready to deploy? Start with Method 3 (manual upload) - it's the fastest!** 🚀
