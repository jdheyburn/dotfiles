#!/usr/bin/env python3


import argparse
import pathlib
import os
import subprocess
import shutil

_FORMATS = ["flac", "mp3"]
_CONVERTED_DEST = pathlib.Path("/home", "jdheyburn", "Music", "converted")


def _parse_args():
    parser = argparse.ArgumentParser(description="Convert files")
    parser.add_argument(
        "format",
        type=str,
        choices=_FORMATS,
        help="the target format to convert to",
    )
    parser.add_argument(
        "--dir",
        "-d",
        type=str,
        required=True,
        help="the source directory to convert from",
    )
    return parser.parse_args()


def main():
    args = _parse_args()
    print(f"{args=}")

    input_path = pathlib.Path(args.dir)

    if args.format == "flac":
        print("Searching for wav in dir")
        files = list(input_path.glob("*.wav"))
        if not files:
            raise Exception("found no .wav files in dir")
        stem = input_path.name
        target_dir = pathlib.Path(_CONVERTED_DEST, "flac", stem)
        print(f"making {target_dir}")
        os.makedirs(target_dir, exist_ok=True)
        for file in files:
            basename = file.stem
            cmd = ["ffmpeg", "-y", "-i", str(file), f"{str(target_dir)}/{basename}.flac"]
            print(cmd)
            subprocess.run(cmd)
    elif args.format == "mp3":
        print("Searching for flac in dir")
        files = list(input_path.glob("*.flac"))
        if not files:
            raise Exception("found no .flav files in dir")
        stem = input_path.name
        target_dir = pathlib.Path(_CONVERTED_DEST, "mp3", stem)
        print(f"making {target_dir}")
        os.makedirs(target_dir, exist_ok=True)
        for file in files:
            basename = file.stem
            cmd = ["ffmpeg", "-y", "-i", str(file), "-b:a", "320k", f"{str(target_dir)}/{basename}.mp3"]
            print(cmd)
            subprocess.run(cmd)
    cover = list(input_path.glob("cover*"))
    if cover:
        print("copying cover")
        shutil.copy(cover[0], target_dir)


main()