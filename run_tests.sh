#!/bin/bash

set -ex

elm-make --yes
elm-test --yes
