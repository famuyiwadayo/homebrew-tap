class Atlas < Formula
  desc "Persistent knowledge graph and AI memory engine"
  homepage "https://github.com/famuyiwadayo/atlas"
  version "0.3.2"
  license "BUSL-1.1"

  # The binary links against these via Homebrew's stable opt/ symlinks.
  depends_on "faiss"
  depends_on "onnxruntime"
  depends_on "sentencepiece"
  depends_on "zstd"

  on_macos do
    on_arm do
      url "https://github.com/famuyiwadayo/atlas-releases/releases/download/v#{version}/atlas-darwin-arm64"
      sha256 "42c898e433629dd91ba4435a2fbf7d77b1514050d2880ea5386ee0a325232381"
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "darwin-arm64" : "darwin-amd64"
    bin.install "atlas-#{arch}" => "atlas"
  end

  def caveats
    <<~EOS
      To get started:
        atlas init
        atlas remember "your first memory"
        atlas recall "memory"

      For Claude Code integration:
        claude mcp add atlas --scope user -- #{bin}/atlas mcp-serve

      For cloud embeddings (requires OpenAI key):
        atlas config set ATLAS_OPENAI_API_KEY sk-your-key

      For local embedding models, run:
        atlas init
      This will set up the model files in ~/.atlas/models/.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/atlas version 2>&1")
    ENV["HOME"] = testpath
    system bin/"atlas", "status"
  end
end
