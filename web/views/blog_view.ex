defmodule AdamczDotCom.BlogView do
  use AdamczDotCom.Web, :view

  def markdown(content) do
    content
    |> Earmark.to_html(%Earmark.Options{gfm: true})
    |> raw
  end

  def post_status(status) do
    if status do
      "Live!"
    else
      "(nobody can see this post yet)"
    end
  end
end
