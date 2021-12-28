defmodule Wabanex.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  # ecto é utilizado para manipulação do banco
  # criar migration
  #   mix ecto.gen.migration <nome>
  # rodar migration
  #   mix ecto.migrate
  # reset (dropa tudo e aplica as migrations de novo)
  #   mix ecto.reset

  # a change ja está preparada internamente pelo Ecto em caso de rollback
  # se for preciso, ela já tem internamente o processo de rollback
  # se precisar de algo mais especifico, é possível implementar as funções "up" e "down"
  # up para alterar o estado do banco
  # down para dar rollback

  def change do
    create table(:users) do
      add :email,     :string
      add :name,      :string
      add :password,  :string
      timestamps() # inserted_at e updated_at
    end

    create unique_index(:users, [:email])
  end
end
