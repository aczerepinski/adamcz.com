defmodule AdamczDotCom.Repo do
  use Ecto.Repo,
    otp_app: :adamcz_dot_com,
    adapter: Ecto.Adapters.Postgres
end
