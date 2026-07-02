# homebrew-vokari

Tap [Homebrew](https://brew.sh) per **[VOKARI](https://github.com/salvoclemenza-hub/vokari)** — da una registrazione vocale a `briefing.md` + recap + note Obsidian, 100% in locale.

## Installazione

```bash
brew install salvoclemenza-hub/vokari/vokari
vokari-app
```

`ffmpeg` e `portaudio` sono installati automaticamente come dipendenze. La formula builda da sorgente (le dipendenze ML — ctranslate2/faster-whisper — sono wheel-only su PyPI). In alternativa al canale Homebrew, su macOS c'è il **DMG** nelle [Release](https://github.com/salvoclemenza-hub/vokari/releases).
