---
description: Deploy NTCC Dashboard to GitHub Pages
---

# Deploy NTCC Dashboard to GitHub Pages

This workflow explains how to deploy the NTCC Dashboard Flutter web app to GitHub Pages.

## Automatic Deployment

The app automatically deploys to GitHub Pages when you push or merge to the `main` branch.

### How it works:
1. Make your changes on a feature branch (e.g., `dev`, `feature/new-chart`)
2. Merge the branch into `main`:
   ```bash
   git checkout main
   git merge dev
   git push origin main
   ```
3. GitHub Actions automatically builds and deploys your app
4. Visit your app at: `https://<your-github-username>.github.io/ntcc_dashboard/`

### Monitoring deployment:
- Go to your GitHub repository
- Click on the "Actions" tab
- View the latest workflow run to see deployment progress

---

## Manual Local Testing

Before deploying, test the web build locally:

### Build for web:
```bash
flutter build web --release --base-href "/ntcc_dashboard/"
```

### Test locally:
```bash
cd build/web
python -m http.server 8000
```

Then visit: `http://localhost:8000`

---

## First-Time Setup

After pushing the workflow file for the first time, you need to enable GitHub Pages:

1. Go to your GitHub repository settings
2. Navigate to: **Settings** → **Pages**
3. Under "Source", select: **GitHub Actions**
4. Save the settings

The next push to `main` will trigger the deployment.

---

## Troubleshooting

### Build fails with "Flutter not found"
- The workflow uses Flutter 3.27.3 stable. If you need a different version, update the `flutter-version` in `.github/workflows/deploy.yml`

### App shows blank page after deployment
- Check browser console for errors
- Verify the base href is correct: `/ntcc_dashboard/`
- Ensure all assets are properly referenced in `pubspec.yaml`

### Deployment succeeds but app not accessible
- Wait 1-2 minutes for GitHub Pages to propagate
- Check GitHub Pages settings are configured correctly
- Verify the URL: `https://<username>.github.io/ntcc_dashboard/`

### Assets not loading (404 errors)
- Ensure all assets in `pubspec.yaml` are included in the build
- Check that asset paths don't start with `/` (use relative paths)
