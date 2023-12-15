# Hamchron

This application is a learning experience for me. This is written in [elixir](https://elixir-lang.org/), [phoenix](https://www.phoenixframework.org/) & [tailwind css](https://tailwindcss.com/).

This software is still very alpha, but is running on a [Inovato Quadra](https://inovato.com/).

I used [Burrito](https://github.com/burrito-elixir/burrito) to compile the binary to be used on the Quadra.

Thanks to the creator of [Hamclock](https://www.clearskyinstitute.com/ham/HamClock/) for creating a great tool for inspiration.

My Call: [NB8F](https://www.qrz.com/db/nb8f)

# Things I had to learn

- Elixir/Phoenix (still learning)
- How to convert a grid square to a latitude / longitude.

# Things I still have to learn

- How to write cleaner/more performant elixir.
- How to test elixir/phoenix.

# Features

- Gets space weather from N0NBH every hour.
- Gets sun images every hour.
- Gets latest spots every 5 mins from PSK Reporter.
- Display spots (around 6k) on the map and highlight them by band.
  - Popup that shows the Callsign, Band & Mode when clicked on.

# Future

- Would like to map contacts from QRZ and display on the map as well.

# Development

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
