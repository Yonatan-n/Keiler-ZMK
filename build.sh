#!/bin/bash
set -e

TIMESTAMP="${TIMESTAMP:-$(date -u +"%Y%m%d%H%M")}"

mkdir -p firmware

# Left half
west build -s zmk/app -b nice_nano -d build/left -p \
  -- -DSHIELD=Keiler_left
cp build/left/zephyr/zmk.uf2 firmware/${TIMESTAMP}_left.uf2

# Right half
west build -s zmk/app -b nice_nano -d build/right -p \
  -- -DSHIELD=Keiler_right
cp build/right/zephyr/zmk.uf2 firmware/${TIMESTAMP}_right.uf2

# Dongle
west build -s zmk/app -b nice_nano -d build/dongle -p \
  -- -DSHIELD=Keiler_dongle
cp build/dongle/zephyr/zmk.uf2 firmware/${TIMESTAMP}_dongle.uf2

# nice!nano reset
west build -s zmk/app -b nice_nano -d build/nn_reset -p \
  -- -DSHIELD=settings_reset
cp build/nn_reset/zephyr/zmk.uf2 firmware/nn_reset.uf2

# XIAO reset
west build -s zmk/app -b nice_nano -d build/xia_reset -p \
  -- -DSHIELD=settings_reset
cp build/xia_reset/zephyr/zmk.uf2 firmware/xia_reset.uf2
