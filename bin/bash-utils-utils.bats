#!/usr/bin/env bash
source ./bash-utils-utils

esc=$'\e'
csi="$esc["

# die test cases
@test "[bash-utils-utils] die: should exit with a given error code" {
  run die 126

  [ "$status" -eq 126 ]
}

@test "[bash-utils-utils] die: should exit with an exit code 1 if not a number was given as argumant" {
  run die something

  [ "$status" -eq 1 ]
}

@test "[bash-utils-utils] die: should print a given text description if it is set" {
  run die 2 "something happend"

  value="${csi}31msomething happend"$'\n'"${csi}m"

  [ "$output" = "$value" ]
}

@test "[bash-utils-utils] die: should not print any if it is not set" {
  run die 2

  [ -z "$output" ]
}

# getEditor test cases
@test "[bash-utils-utils] getEditor: should return an editor if it is set" {
  EDITOR=vim
  run getEditor
  [ "$output" = vim ]
}

@test "[bash-utils-utils] getEditor: should return vi as a default editor if it is not set" {
  EDITOR=
  run getEditor
  [ "$output" = vi ]
}

# bash-utils-utils test cases
@test "[bash-utils-utils] bash-utils-utils die: should proxy its arguments to the die function" {
  run bash-utils-utils die 3 'Something wrong has happend'

  value="${csi}31mSomething wrong has happend"$'\n'"${csi}m"

  [ "$status" -eq 3 ]
  [ "$output" = "$value" ]
}

@test "[bash-utils-utils] bash-utils-utils *: should exit with an error message if an unknow command was given" {
  run bash-utils-utils something 3 'Something wrong has happend'

  value="${csi}31mAn unknown command bash-utils-utils something"$'\n'"${csi}m"

  [ "$status" -eq 2 ]
  [ "$output" = "$value" ]
}
