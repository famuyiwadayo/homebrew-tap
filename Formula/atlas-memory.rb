class AtlasMemory < Formula
  desc "Persistent knowledge graph and AI memory engine"
  homepage "https://github.com/famuyiwadayo/atlas"
  version "0.3.3"
  license "BUSL-1.1"

  # Conflicts with atlasgo's atlas formula (both install an `atlas` binary).
  conflicts_with "atlas", because: "both install an `atlas` binary"

  # The binary links against these via Homebrew's stable opt/ symlinks.
  depends_on "faiss"
  depends_on "onnxruntime"
  depends_on "sentencepiece"
  depends_on "zstd"

  on_macos do
    on_arm do
      url "https://github.com/famuyiwadayo/atlas-releases/raw/v0.3.3/atlas-darwin-arm64"
      sha256 "31fa9591ce78405c23d85aac60ed6c01e1c17b7a436b55c11290402635a3503a"
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
