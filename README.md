# Objects

```bash
bash> make all
iex> :observer.start
iex> Process.whereis Elixir.Objects.Registry
#=> #PID<0.182.0>
iex> Process.info(pid(0,182,0))
```

```bash
lib
├── objects
│   ├── application.ex
│   ├── builder.ex
│   └── registry.ex
└── objects.ex

1 directory, 4 files
```

### 14 November 2018 by Oleg G.Kapranov

[1]: https://elixirschool.com/en/
[2]: https://elixir-lang.org/getting-started/introduction.html
[3]: https://hexdocs.pm/elixir/Process.html
[4]: https://hexdocs.pm/elixir/GenServer.html
[5]: https://hexdocs.pm/elixir/Agent.html
[6]: https://wunsh.ru/docs/processes.html
[7]: https://wunsh.ru/docs/mix-otp/genserver
[8]: https://wunsh.ru/docs/mix-otp/agent.html
