#!/usr/bin/env bash
source ./bash-utils-env

# bash-utils-env test cases
@test "[bash-utils-env] bash-utils-env: should return the value of a given env variable" {

  [ "$(bash-utils-env version)" = '0.1.0' ]
  [ "$(bash-utils-env misuseErrorCode)" -eq 2 ]
}
