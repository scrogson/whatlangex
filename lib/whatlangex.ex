defmodule Whatlangex do
  @moduledoc """
  Documentation for `Whatlang`.
  """

  alias Whatlangex.Native

  defmodule Detection do
    @moduledoc """
    Module of the Detection type.
    """

    @type t :: %__MODULE__{
            lang: String.t(),
            script: String.t(),
            confidence: float()
          }

    defstruct [:lang, :script, :confidence]
  end

  @doc """
  Detect the language of the given sentence.

  ## Examples

      iex> detect("This is a cool sentence.")
      "eng"

  """
  @spec detect(String.t()) :: {:ok, Detection.t()} | :none
  def detect(sentence) do
    case Native.detect(sentence) do
      nil ->
        :none

      %Detection{} = detection ->
        {:ok, detection}
    end
  end

  @doc """
  Get full language name (native) from language code.

  ## Examples

      iex> code_to_eng_name("fra")
      "Français"

  """
  @spec code_to_name(String.t()) :: {:ok, String.t()} | :not_found
  def code_to_name(sentence) do
    case Native.code_to_name(sentence) do
      nil -> :not_found
      lang_name -> {:ok, lang_name}
    end
  end

  @doc """
  Get full language name (in English) from language code.

  ## Examples

      iex> code_to_name("eng")
      "English"

  """
  @spec code_to_eng_name(String.t()) :: {:ok, String.t()} | :not_found
  def code_to_eng_name(sentence) do
    case Native.code_to_eng_name(sentence) do
      nil -> :not_found
      lang_name -> {:ok, lang_name}
    end
  end
end
