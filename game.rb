#!/usr/bin/env ruby
# encoding: utf-8
require "gosu"
require "singleton"

require_relative "core/bee"
require_relative "core/bomb"
require_relative "core/weapon"
require_relative "core/flower"
require_relative "core/enemy_bee"
require_relative "core/world"
require_relative "core/game_window"

GameWindow.instance.show