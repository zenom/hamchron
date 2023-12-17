# Hamchron

A simple clock that shows UTC and local time, shows space weather, spots from PSKReporter, gray line etc.,

View a demo [HERE](https://hamchron-summer-rain-4857.fly.dev/)

<img width="2547" alt="Screenshot 2023-12-15 at 1 59 00 PM" src="https://github.com/zenom/hamchron/assets/175725/52c798b2-edc9-42d1-bfc8-ceaf042cdee1">

I gather data from the following places:

- [PSK Reporter](https://pskreporter.info/)
- [PSK Reporter MQTT](http://mqtt.pskreporter.info/)
- [N0NBH/HamQSL](https://www.hamqsl.com/solar.html)

This application is a learning experience for me. This is written in [elixir](https://elixir-lang.org/), [phoenix](https://www.phoenixframework.org/) & [tailwind css](https://tailwindcss.com/).

This software is still very alpha, but is running on a [Inovato Quadra](https://inovato.com/).

I used [Burrito](https://github.com/burrito-elixir/burrito) to compile the binary to be used on the Quadra.

Thanks to the creator of [Hamclock](https://www.clearskyinstitute.com/ham/HamClock/) for creating a great tool for inspiration.

My Call: [NB8F](https://www.qrz.com/db/nb8f)

# How to run

- Go to releases and download the latest version.
- You can run this a couple of ways. If you just want to test it out you can run.

`PHX_SERVER=1 CALLSIGN=<YOURCALL> GRID_SQUARE=<YOUR_GRID> SECRET_KEY_BASE=<64 chars string> ./hamchron_(OS)_(ARCH)`

You can also use the services file that is located in support to create a systemd service to run.

- From here open a web browser and go to `http://localhost:8888` and you should see the web based hamchron.

# Another way to run / online.

- You can run this on your own web service as well. I use fly.io for the demo there are free and cheap ($5 mo) packages.

# Yet another way

- You can download this repo and run the app yourelf.

# Standalone Firmware

- Take a look at the nerves branch and it will allow you to build a firmware for a rasberry pi. You would need a separte browser to display.

# Things I had to learn

- Elixir/Phoenix (still learning)
- How to convert a grid square to a latitude / longitude.

# Things I still have to learn

- How to write cleaner/more performant elixir.
- How to test elixir/phoenix.

# Features

- Gets space weather from N0NBH every hour.
- Gets sun images every hour.
- Realtime spots (1000) from PSK Reporter, dynamically updated.
- Display spots on the map and highlight them by band.
  - Popup that shows the Callsign, Band, Mode & Grid Square heard when clicked on.

# Future

- Would like to map contacts from QRZ and display on the map as well.
- Layer filter to see spots by band instead of all.
- Improve download/deploy.

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
