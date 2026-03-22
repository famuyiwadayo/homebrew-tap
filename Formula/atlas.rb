class Atlas < Formula
  desc "Persistent knowledge graph and AI memory engine"
  homepage "https://github.com/famuyiwadayo/atlas"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/famuyiwadayo/atlas-releases/releases/download/v0.2.0/atlas-darwin-arm64"
      sha256 "b8e5f45ab0de8bf37b7beca5875fefd8e66c5d02f605b116c1a0c5bb05a14de6"
    end
  end

  def install
    binary = Dir["atlas-*"].first || "atlas"
    bin.install binary => "atlas"
  end

  def post_install
    # Create data directory
    (var/"atlas").mkpath
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

      For local embeddings (no API key needed):
        brew install faiss onnxruntime
        Download the model: curl -fsSL https://github.com/famuyiwadayo/atlas-releases/releases/download/v0.2.0/embed-local.onnx -o ~/.atlas/models/embed-local.onnx
    EOS
  end

  test do
    assert_match "atlas", shell_output("#{bin}/atlas version")
  end
end
