# YouTube Caption Extractor (PowerShell)

A PowerShell script to fetch and extract YouTube subtitles using Node.js and `youtube-caption-extractor`. This script retrieves captions from a given YouTube video, saves them in JSON format, and extracts the text into a readable `.txt` file.

## 🚀 Features
- Fetches **YouTube subtitles** (both auto-generated and user-submitted)
- Saves the captions in a **JSON file**
- Extracts subtitle text and saves it as a **.txt file**
- Simple **one-command execution**
- Supports **multiple languages**

---

## 🛠 Installation
Before running the script, you need to install **Node.js** and the `youtube-caption-extractor` npm package.

### 1️⃣ Install Node.js
Download and install Node.js from:  
🔗 [https://nodejs.org/en](https://nodejs.org/en)

### 2️⃣ Install Required NPM Package
After installing Node.js, open **PowerShell** and run:
```powershell
npm install -g youtube-caption-extractor
```

This installs `youtube-caption-extractor` globally, allowing the script to function properly.

---

## 📜 Usage
Once dependencies are installed, you can use the script:

### 1️⃣ Open PowerShell and Run:
```powershell
Get-YouTubeCaptions -videoID "YOUR_VIDEO_ID"
```
This fetches captions for the given YouTube video ID.

### 2️⃣ Extract Subtitles from JSON:
```powershell
Extract-Subtitles
```
This parses the JSON file and saves only the subtitle text to a `.txt` file.

### 3️⃣ View the Extracted Subtitles:
```powershell
Get-Content -Path "$env:USERPROFILE\Desktop\YouTubeSubtitles.txt"
```

---

## 📂 File Outputs
- `YouTubeCaptions.json` (stored on Desktop) → Contains full subtitle data
- `YouTubeSubtitles.txt` (stored on Desktop) → Contains only subtitle text

---

## 🛑 Troubleshooting
### **1. Command Not Found?**
If `Get-YouTubeCaptions` doesn’t work, reload your PowerShell session or ensure the script is sourced properly.

### **2. Node.js Not Installed?**
Run:
```powershell
node -v
```
If you don’t see a version, reinstall Node.js from [here](https://nodejs.org/en).

### **3. Package Not Found?**
Run:
```powershell
npm list -g --depth=0
```
If `youtube-caption-extractor` is missing, reinstall it using:
```powershell
npm install -g youtube-caption-extractor
```

---

## 📜 License
This project is open-source and available under the **MIT License**.

---

## 💡 Future Enhancements
✅ Support for batch processing multiple videos  
✅ Option to specify custom save locations  
✅ Additional formatting for extracted subtitles  

---

## ❤️ Contributing
Feel free to submit pull requests or open issues if you’d like to improve this script!

---

## 📞 Contact
If you need help or have suggestions, open an issue on this repository!

---

Happy Caption Extracting! 🎬✨

