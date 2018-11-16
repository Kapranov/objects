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

[1]:  https://elixirschool.com/en/
[2]:  https://elixir-lang.org/getting-started/introduction.html
[3]:  https://hexdocs.pm/elixir/Process.html
[4]:  https://hexdocs.pm/elixir/GenServer.html
[5]:  https://hexdocs.pm/elixir/Agent.html
[6]:  https://wunsh.ru/docs/processes.html
[7]:  https://wunsh.ru/docs/mix-otp/genserver
[8]:  https://wunsh.ru/docs/mix-otp/agent.html
[9]:  https://elixir-lang.org/getting-started/meta/macros.html
[10]: https://elixirschool.com/en/lessons/advanced/metaprogramming/
[11]: https://www.bignerdranch.com/blog/getting-started-with-elixir-metaprogramming/
[12]: https://dockyard.com/blog/2016/08/16/the-minumum-knowledge-you-need-to-start-metaprogramming-in-elixir
[13]: https://hackernoon.com/understanding-elixir-macros-3464e141434c
[14]: https://code.tutsplus.com/articles/elixir-metaprogramming-basics--cms-30011
[15]: https://medium.com/blackode/write-your-first-macro-elixir-meta-programming-31037e1d83bf
[16]: https://medium.com/@Mike_Andr/understanding-elixirs-macros-by-phoenix-example-e99827a60987
[17]: https://www.theerlangelist.com/article/macros_1
[18]: https://www.theerlangelist.com/article/macros_2
[19]: https://www.theerlangelist.com/article/macros_3
[20]: https://www.theerlangelist.com/article/macros_4
[21]: https://www.theerlangelist.com/article/macros_5
[22]: https://www.theerlangelist.com/article/macros_6
