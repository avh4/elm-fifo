#!/bin/bash

cd tests
elm-make --yes
elm-test TestRunner.elm
