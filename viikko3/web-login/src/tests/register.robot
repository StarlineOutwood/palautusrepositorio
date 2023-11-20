*** Settings ***
Resource  resource.robot
Suite Setup  Open And Configure Browser
Suite Teardown  Close Browser
Test Setup  Go To Registering

*** Test Cases ***

Register With Valid Username And Password
    Set Username  kalleuusi
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Credentials
    Registeration Should Succeed

Register With Too Short Username And Valid Password
    Set Username  a
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Credentials
    Registeration Should Fail With Message  Username is too short

Register With Valid Username And Invalid Password
    Set Username  kivakalle
    Set Password  huonosalasana
    Set Password Confirmation  huonosalasana
    Submit Credentials
    Registeration Should Fail With Message  Password contains only letters

Register With Nonmatching Password And Password Confirmation
    Set Username  kivakalle
    Set Password  huonosalasana1
    Set Password Confirmation  huonosalasana2
    Submit Credentials
    Registeration Should Fail With Message  Passwords are not the same

Login After Successful Registration
    Set Username  kalleuusikiva
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Credentials
    Open Login
    Set Username  kalleuusikiva
    Set Password  kalle123
    Login
    Login Should Succeed

Login After Failed Registration
    Set Username  kalleuusivaara
    Set Password  kalle
    Set Password Confirmation  kalle
    Submit Credentials
    Open Login
    Set Username  kalleuusikiva
    Set Password  kalle
    Login
    Login Should Fail With Message  Invalid username or password

*** Keywords ***
Go To Registering
    Go To Register Page
    Register Page Should Be Open

Submit Credentials
    Click Button  Register

Set Username
    [Arguments]  ${username}
    Input Text  username  ${username}

Set Password
    [Arguments]  ${password}
    Input Password  password  ${password}

Set Password Confirmation
    [Arguments]  ${password_confirmation}
    Input Password  password_confirmation  ${password_confirmation}

Registeration Should Succeed
    Home Page Should Be Open

Registeration Should Fail With Message
    [Arguments]  ${message}
    Register Page Should Be Open
    Page Should Contain  ${message}

Login Should Succeed
    Main Page Should Be Open

Login Should Fail With Message
    [Arguments]  ${message}
    Login Page Should Be Open
    Page Should Contain  ${message}

Open Login
    Go To Login Page

Login
    Click Button  Login