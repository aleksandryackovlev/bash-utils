#!/usr/bin/env bash

source ./bash-utils-validate

# required test cases
@test "[bash-utils-validate] bash-utils-validate required: return an error string if an empty argument was given" {
  run bash-utils-validate required ''

  [ "$output" = "The field is required" ]
}

@test "[bash-utils-validate] bash-utils-validate required: return an empty string if a valid value was given" {
  run bash-utils-validate required 'test'

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate required -r: return an empty string if an empty value was given" {
  run bash-utils-validate required -r ''

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate required -r: return an error string if not an empty argument was given" {
  run bash-utils-validate required -r 'test'

  [ "$output" = "The field should be empty" ]
}

# number test cases
@test "[bash-utils-validate] bash-utils-validate number: return an error string if not a number argument was given" {
  run bash-utils-validate number 'fkd'

  [ "$output" = "Not a number was given" ]
}

@test "[bash-utils-validate] bash-utils-validate number: return an empty string if a valid value was given" {
  run bash-utils-validate number 32

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate number -r: return an empty string if not a number was given" {
  run bash-utils-validate number -r 'string'

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate number -r: return an error string if not a number was given" {
  run bash-utils-validate number -r 34

  [ "$output" = "A number was given" ]
}

# alnum test cases
@test "[bash-utils-validate] bash-utils-validate alnum: return an error string if not an alnum argument was given" {
  run bash-utils-validate alnum 'fk d'

  [ "$output" = "Not an alnum was given" ]
}

@test "[bash-utils-validate] bash-utils-validate alnum: return an empty string if a valid value was given" {
  run bash-utils-validate alnum 32f

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate alnum -r: return an empty string if not a alnum was given" {
  run bash-utils-validate alnum -r 'st ring'

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate alnum -r: return an error string if not a alnum was given" {
  run bash-utils-validate alnum -r 34f

  [ "$output" = "An alnum was given" ]
}

# file test cases
@test "[bash-utils-validate] bash-utils-validate file: return an error string if not a file argument was given" {
  run bash-utils-validate file fkd

  [ "$output" = "File does not exist" ]
}

@test "[bash-utils-validate] bash-utils-validate file: return an empty string if a valid value was given" {
  run bash-utils-validate file ./bash-utils-validate

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate file -r: return an empty string if not a file was given" {
  run bash-utils-validate file -r ddjkl

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate file -r: return an error string if file already exists" {
  run bash-utils-validate file -r ./bash-utils-validate

  [ "$output" = "File already exists" ]
}

# directory test cases
@test "[bash-utils-validate] bash-utils-validate directory: return an error string if not a directory argument was given" {
  run bash-utils-validate directory fkd

  [ "$output" = "Directory does not exist" ]
}

@test "[bash-utils-validate] bash-utils-validate directory: return an empty string if a valid value was given" {
  run bash-utils-validate directory ../bin

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate directory -r: return an empty string if not a directory was given" {
  run bash-utils-validate directory -r ddjkl

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate directory -r: return an error string if directory already exists" {
  run bash-utils-validate directory -r ../bin

  [ "$output" = "Directory already exists" ]
}

# yesOrNo test cases
@test "[bash-utils-validate] bash-utils-validate yesOrNo: return an error string if yes or no argument was given" {
  run bash-utils-validate yesOrNo 'jk'

  [ "$output" = "Not yes or no value was given" ]
}

@test "[bash-utils-validate] bash-utils-validate yesOrNo: return an empty string if a valid value was given" {
  run bash-utils-validate yesOrNo 'y'

  [ "$output" = "" ]
}

@test "[bash-utils-validate] bash-utils-validate *: return an error string if an unknown command was given" {
  run bash-utils-validate something 'jk'

  [ "$output" = "An unknown command bash-utils-validate something" ]
}
