#!/bin/bash
set -ex

gem install bundler
bundle update --bundler
bundle install