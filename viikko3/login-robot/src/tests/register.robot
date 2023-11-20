*** Settings ***
Resource  resource.robot
Test Setup  Create User And Input New Command

*** Test Cases ***
Register With Valid Username And Password
    Input Credentials  kallee  kalle123
    Output Should Contain  New user registered

Register With Already Taken Username And Valid Password
    Input Credentials  kalle  kalle123
    Output Should Contain  User with username kalle already exists

Register With Too Short Username And Valid Password
    Input Credentials  a  kalle123
    Output Should Contain  Username is less than three characters

Register With Enough Long But Invalid Username And Valid Password
    Input Credentials  kalle!  kalle123
    Output Should Contain  Username has forbidden characters

Register With Valid Username And Too Short Password
    Input Credentials  kalle  ss
    Output Should Contain  Password is less than eight characters

Register With Valid Username And Long Enough Password Containing Only Letters
    Input Credentials  kalle  abcdefghijklmn
    Output Should Contain  Password consists of only letters

*** Keywords ***
Create User And Input New Command
    Create User  kalle  kalle123
    Input New Command