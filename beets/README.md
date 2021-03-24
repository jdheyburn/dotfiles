# beet

`beet` is a wrapper around Beets' own `beet` that gives some safeguards about the music you are importing.

I have 3 distinct types of music collections - `.mp3` (music), `.flac` from vinyl ripping (vinyl), and `.flac` from other sources (lossless).

In order to make sure I don't accidentally add `.mp3` to the lossless collection, and vice versa, this tool will analyse the `import` command and the path being imported to determine what files would be included. It will error out if the database to import to does not support an extension.

Based on the database you are targeting, it will use its respective config file in this same directory too.

## Usage

Assuming you have `$HOME/dotfiles/bin` on your `$PATH`:

To import mp3s:

```bash
beet music import /path/to/music
```

To import lossless:

```bash
beet lossless import /path/to/lossless
```

To import vinyl:

```bash
beet vinyl import /path/to/vinyl
```

The wrapper only added the additional `config` positional argument - the rest of the arguments are passed to the `.venv/bin/beet` binary. Therefore you can run commands such as this still:

```bash
beet music list artist:Celer
```

## Setup

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
```

If `$HOME/dotfiles/bin` is on the `$PATH` then simply running `beet` will verify it.
