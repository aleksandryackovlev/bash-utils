#!/usr/bin/env bash
source ./bash-utils-input

esc=$'\e'
csi="$esc["

interact() {
  echo "${csi}B"
  sleep 1
  echo q
}

# textInput test cases
@test "[bash-utils-input] textInput: should read the user input and return" {
  run textInput -p "what is the text?" <<< "some input"

  [ "$output" = "some input" ]
}

@test "[bash-utils-input] textInput: should set a variable to a default value if the input was empty" {
  run textInput -p "what is the text? " -d 'test' <<< ''

  [ "$output" = "test" ]
}

@test "[bash-utils-input] radioInput: should read the user yes or no answer and return" {
  run radioInput -p "what is the text?" <<< "y"

  [ "$output" = "y" ]
}

@test "[bash-utils-input] selectInput: should set a global variable input to the given value" {
  selectInput -C "test1:test1" "test3:test3" "test2:test2" <<< $(interact) >/dev/null

  [ "$input" = "test3" ]
}

@test "[bash-utils-input] bash-utils-input text: should proxy its arguments to the textInput function" {
  run bash-utils-input text -p "what is the text?" <<< "some input"

  [ "$output" = "some input" ]
}

@test "[bash-utils-input] bash-utils-input select: should proxy its arguments to the selectInput function" {
  bash-utils-input select -C "test1:test1" "test3:test3" "test2:test2" <<< $(interact) >/dev/null

  [ "$input" = "test3" ]
}

@test "[bash-utils-input] bash-utils-input radio: should proxy its arguments to the radioInput function" {
  run bash-utils-input radio -p "what is the text?" <<< "y"

  [ "$output" = "y" ]
}

@test "[bash-utils-input] bash-utils-input *: should exit with an error message if an unknow command was given" {
  run bash-utils-input something 3 'Something wrong has happend'

  [ "$status" -eq 2 ]
  value="${csi}31mAn unknown command bash-utils-input something"$'\n'"${csi}m"
  [ "$output" = "$value" ]
}
