*** Settings ***
Documentation  This is to import libraries and resources
Library    SeleniumLibrary
Library    XML
Library    Collections
Library    DateTime
Library    Dialogs
Library    OperatingSystem
Library    Process
Library    Screenshot
Library    String
Library    Telnet
Library    BuiltIn

*** Test Cases ***
Demo_Mode
    [Documentation]     This is demo mode test.
    Open Browser       https://www.  .com/   browser=chrome
