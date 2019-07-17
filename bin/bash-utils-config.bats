#!/usr/bin/env bash
source ./bash-utils-config

setup() {
  configFileName='.bash-utils-rc'
  globalConfigFile="$HOME/$configFileName"
  printf "createFileComponent=0\n someVar=test" > "$globalConfigFile"
  printf "createFileComponent=1\n" > ./"$configFileName"
}

teardown() {
  if [ -f "$globalConfigFile" ]; then
    rm "$globalConfigFile"
  fi

  if [ -f "./$configFileName" ]; then
    rm ./"$configFileName"
  fi
}

# readGlobalConfig test cases
@test "[bash-utils-config] readGlobalConfig: should read the variables from the global config file" {
  readGlobalConfig

  [ "$createFileComponent" -eq 0 ]
}

# readLocalConfig test cases
@test "[bash-utils-config] readLocalConfig: should read the variables from the local config file" {
  readLocalConfig

  [ "$createFileComponent" -eq 1 ]
}

# findLocalConfig test cases
@test "[bash-utils-config] findLocalConfig: should find the local config file" {
  run findLocalConfig
  configFile="$PWD"/.bash-utils-rc

  [ "$output" = "$configFile" ]
}

# editConfigFile
@test "[bash-utils-config] editConfigFile: should open a config file in a default editor" {
  EDITOR=echo
  run editConfigFile
  expectedConfigFile="$PWD"/.bash-utils-rc

  [ "$output" =  "$expectedConfigFile" ]
}

@test "[bash-utils-config] editConfigFile: should throw an error if a local config file doesn't exist" {
  configFileName=abracadabre
  run editConfigFile
  [ "$status" -eq 1 ]

  value="${csi}31mA local config file doesn't exist"$'\n'"${csi}m"
  [ "$output" = "$value" ]
}

# editConfigFile
@test "[bash-utils-config] createConfigFile: should create a config file and open it in a default editor" {
  EDITOR=cat
  expectedConfigFile="$PWD"/.bash-utils-rc

  rm "$expectedConfigFile"

  [ ! -f "$expectedConfigFile" ]

  run createConfigFile

  [ -f "$expectedConfigFile" ]
  [ "${lines[0]}" = 'bashUtilsConfig=example' ]
}

@test "[bash-utils-config] createConfigFile: should throw an error if a local config file already exists" {
  expectedOutput="${csi}31mA file ${PWD}/.bash-utils-rc already exists"$'\n'"${csi}m"

  run createConfigFile

  [ "$status" -eq 1 ]
  [ "$output" =  "$expectedOutput" ]
}

@test "[bash-utils-config] createConfigFile: should create a config file in a given directory and open it in a default editor" {
  EDITOR=cat
  dir="$HOME"/"$RANDOM"

  mkdir "$dir"

  expectedConfigFile="$dir"/.bash-utils-rc

  [ ! -f "$expectedConfigFile" ]

  run createConfigFile "$dir"

  [ -f "$expectedConfigFile" ]
  [ "${lines[0]}" = 'bashUtilsConfig=example' ]

  rm -rf "$dir"
}

@test "[bash-utils-config] createConfigFile: should throw an error if a given directory doesn't exist" {
  expectedOutput="${csi}31mA directory /abracadabra doesn't exist"$'\n'"${csi}m"

  run createConfigFile /abracadabra

  [ "$status" -eq 1 ]
  [ "$output" =  "$expectedOutput" ]
}

@test "[bash-utils-config] deleteConfigFile: should delete a config file if it exists" {
  expectedConfigFile="$PWD"/.bash-utils-rc

  [ -f "$expectedConfigFile" ]

  run deleteConfigFile

  [ ! -f "$expectedConfigFile" ]
}

# readConfig test cases
@test "[bash-utils-config] readConfig: should read the variables from the global and the local config files" {
  readConfig

  [ "$createFileComponent" -eq 1 ]
  [ "$someVar" = test ]
}

# bash-utils-config test cases
@test "[bash-utils-config] create: should proxy its arguments to the createConfigFile function" {
  EDITOR=cat
  expectedConfigFile="$PWD"/.bash-utils-rc

  rm "$expectedConfigFile"

  [ ! -f "$expectedConfigFile" ]

  run bash-utils-config create

  [ -f "$expectedConfigFile" ]
  [ "${lines[0]}" = 'bashUtilsConfig=example' ]
}

@test "[bash-utils-config] bash-utils-config edit: should proxy its arguments to the editConfigFile function" {
  EDITOR=echo
  run bash-utils-config edit
  expectedConfigFile="$PWD"/.bash-utils-rc

  [ "$output" =  "$expectedConfigFile" ]
}

@test "[bash-utils-config] bash-utils-config read: should proxy its arguments to the readConfigFile function" {
  bash-utils-config read

  [ "$createFileComponent" -eq 1 ]
}

@test "[bash-utils-config] bash-utils-config delete: should proxy its arguments to the deleteConfigFile function" {
  expectedConfigFile="$PWD"/.bash-utils-rc

  [ -f "$expectedConfigFile" ]

  run bash-utils-config delete

  [ ! -f "$expectedConfigFile" ]
}

@test "[bash-utils-config] bash-utils-config *: should exit with an error message if an unknow command was given" {
  run bash-utils-config something

  [ "$status" -eq 2 ]
  value="${csi}31mAn unknown command bash-utils-config something"$'\n'"${csi}m"
  [ "$output" = "$value" ]
}
