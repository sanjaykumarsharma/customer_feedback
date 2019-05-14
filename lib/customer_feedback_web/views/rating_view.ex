defmodule CustomerFeedbackWeb.RatingView do
  use CustomerFeedbackWeb, :view

  def format_date(dt) when is_nil(dt) do
    ""
  end

  def format_date(dt) do
    to_string(dt.day) <> "/" <> to_string(dt.month) <> "/" <> to_string(dt.year)
  end
end
