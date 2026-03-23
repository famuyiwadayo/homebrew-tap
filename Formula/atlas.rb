class Atlas < Formula
  desc "Persistent knowledge graph and AI memory engine"
  homepage "https://github.com/famuyiwadayo/atlas"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/famuyiwadayo/atlas-releases/releases/download/v0.2.1/atlas-darwin-arm64"
      sha256 "73b29067b57a314299a74c783ab9eaf57eb987bc6d265ccda0e3e01bba727baa"
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
        Download the model: curl -fsSL https://github.com/famuyiwadayo/atlas-releases/releases/download/v0.2.1/embed-local.onnx -o ~/.atlas/models/embed-local.onnx
    EOS
  end

  test do
    assert_match "atlas", shell_output("#{bin}/atlas version")
  end
end
