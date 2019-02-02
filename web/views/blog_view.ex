defmodule AdamczDotCom.BlogView do
  use AdamczDotCom.Web, :view

  def markdown(content) do
    content
    |> Earmark.as_html!(%Earmark.Options{gfm: true})
    |> raw
  end

  def post_status(status) do
    if status do
      "Live!"
    else
      "(nobody can see this post yet)"
    end
  end

  def current_date() do
    #2016-10-13 00:00:00
    DateTime.utc_now()
  end

  def is_checked(tag, changeset) do
    if changeset.data.tags do
      tag.id in changeset.data.tags
    else
      false
    end
  end
end
