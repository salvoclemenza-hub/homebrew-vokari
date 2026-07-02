class Vokari < Formula
  include Language::Python::Virtualenv

  desc "Voce -> conoscenza strutturata, 100% in locale (trascrizione + briefing)"
  homepage "https://github.com/salvoclemenza-hub/vokari"
  # Il tarball della GitHub Release DEVE includere frontend/dist già buildato: il wheel lo
  # force-include in app/_webdist (pywebview serve quel dist). Rigenerare url+sha a ogni release:
  #   VER=0.2.1
  #   url  = https://github.com/salvoclemenza-hub/vokari/releases/download/v$VER/vokari-$VER.tar.gz
  #   sha256 = shasum -a 256 vokari-$VER.tar.gz
  url "https://github.com/salvoclemenza-hub/vokari/releases/download/v0.2.1/vokari-0.2.1.tar.gz"
  sha256 "ef7a2e657e94387f82687be109a2ff3fab16665e113ed1e27fb5c67fd309207e"
  license "MIT"

  depends_on "ffmpeg" # conversione audio (obbligatorio a runtime)
  depends_on "portaudio" # PortAudio per sounddevice (cattura microfono)
  depends_on "python@3.12"

  # NOTA (importante): niente blocchi `resource` idiomatici. Diverse dipendenze ML sono
  # WHEEL-ONLY su PyPI (ctranslate2, faster-whisper: nessun sdist) → il meccanismo standard
  # `virtualenv_install_with_resources`, che builda i resource da sorgente, non è applicabile.
  # Installiamo quindi il pacchetto e le sue dipendenze via pip (da wheel) nel virtualenv.
  # È non idiomatico (brew audit lo segnala) ma è l'unica via realistica su un tap personale.
  # Il canale di distribuzione "senza dipendenze" resta il DMG/.app (PyInstaller).

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # pip risolve ctranslate2/faster-whisper/tokenizers/numpy dai wheel arm64 pubblicati.
    system venv.root/"bin/pip", "install", "--verbose", buildpath
    bin.install_symlink libexec/"bin/vokari"
    bin.install_symlink libexec/"bin/vokari-app"
  end

  test do
    # La CLI deve almeno rispondere (import dell'intero stack + typer).
    assert_match "vokari", shell_output("#{bin}/vokari --help")
  end
end
