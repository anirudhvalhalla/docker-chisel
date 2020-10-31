#!/bin/bash

set -e
exec glider -listen :$SOCKS5_PORT -verbose 2>&1 &
exec chisel server --port $PORT --reverse --backend http://0.0.0.0:$BACKEND_PORT --socks5 --auth "$CHISEL_USERNAME:$CHISEL_PASSWORD"