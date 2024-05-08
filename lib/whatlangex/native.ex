defmodule Whatlangex.Native do
  @moduledoc false

  version = Mix.Project.config()[:version]
  force_build = Application.compile_env(:rustler_precompiled, :force_build, [])
  default_url = "https://github.com/pierrelegall/whatlangex/releases/download/v#{version}"
  base_url = Application.compile_env(:whatlangex, :base_url, default_url)

  use RustlerPrecompiled,
    otp_app: :whatlangex,
    crate: "whatlang_nif",
    base_url: base_url,
    force_build: System.get_env("RUSTLER_BUILD") in ["1", "true"] or force_build[:whatlangex],
    nif_versions: ["2.15"],
    targets: [
      "aarch64-apple-darwin",
      "aarch64-unknown-linux-gnu",
      "aarch64-unknown-linux-musl",
      "arm-unknown-linux-gnueabihf",
      "x86_64-apple-darwin",
      "x86_64-pc-windows-gnu",
      "x86_64-pc-windows-msvc",
      "x86_64-unknown-linux-gnu",
      "x86_64-unknown-linux-musl"
    ],
    version: version

  def detect(_sentence), do: nif_error()
  def code_to_name(_sentence), do: nif_error()
  def code_to_eng_name(_sentence), do: nif_error()

  defp nif_error, do: :erlang.nif_error(:nif_not_loaded)
end
