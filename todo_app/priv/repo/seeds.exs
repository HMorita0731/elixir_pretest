alias TodoApp.Repo
alias TodoApp.Accounts.User
alias TodoApp.Tasks.Task

params = [
  {"user01@example.com", "user01999"},
  {"user02@example.com", "user02999"},
  {"user03@example.com", "user03999"}
]

[u01, u02, u03] =
  Enum.map(params, fn {email, password} ->
    Repo.insert!(%User{
      email: email,
      hashed_password: Pbkdf2.hash_pwd_salt(password),
      confirmed_at: DateTime.truncate(DateTime.utc_now(), :second)
    })
  end)

Repo.insert!(%Task{
  title: "Read a book",
  date: ~D{2024-07-27},
  user_id: u01.id
})

Repo.insert!(%Task{
  title: "Write an e-mail",
  date: ~D{2024-07-28},
  user_id: u01.id
})

Repo.insert!(%Task{
  title: "Buy eggs",
  date: ~D{2024-07-31},
  user_id: u01.id
})

Repo.insert!(%Task{
  title: "Go to the bank",
  date: ~D{2024-07-27},
  user_id: u02.id
})

Repo.insert!(%Task{
  title: "Cut my hair",
  date: ~D{2024-07-27},
  user_id: u02.id
})

Repo.insert!(%Task{
  title: "Join summer festival",
  date: ~D{2024-07-27},
  user_id: u02.id
})

Repo.insert!(%Task{
  title: "Sleep well",
  date: ~D{2024-07-26},
  user_id: u03.id
})
