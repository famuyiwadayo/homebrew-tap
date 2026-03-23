class Atlas < Formula
  desc "Persistent knowledge graph and AI memory engine"
  homepage "https://github.com/famuyiwadayo/atlas"
  version "0.2.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/famuyiwadayo/atlas-releases/releases/download/v0.2.4/atlas-v0.2.4-darwin-arm64.tar.gz"
      sha256 "5310bb71f2f0089bb2bfae4e6e699f7e2d80c0d819c2446dbe230c8338c87088"
    end
  end

  def install
    bin.install "bin/atlas"
    lib.install Dir["lib/*"]
    (share/"atlas/models").install Dir["models/*"]
  end

  def caveats
    <<~EOS
      To get started:
        atlas init
        atlas remember "your first memory"
        atlas recall "memory"

      For Claude integration:
        claude mcp add atlas --scope user -- #{bin}/atlas mcp-serve

      For semantic search, set your OpenAI API key:
        atlas config set ATLAS_OPENAI_API_KEY sk-your-key

      Local embedding model installed at:
        #{share}/atlas/models/embed-local.onnx

      To use it:
        mkdir -p ~/.atlas/models
        ln -sf #{share}/atlas/models/* ~/.atlas/models/
    EOS
  end

  test do
    assert_match "atlas", shell_output("#{bin}/atlas version 2>&1")
  end
end
