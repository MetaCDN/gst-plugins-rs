#!/bin/bash

cargo install cargo-c
cargo cbuild --manifest-path video/closedcaption/Cargo.toml --prefix=/usr/local
cargo cinstall --manifest-path video/closedcaption/Cargo.toml --prefix=/usr/local
