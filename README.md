# Display-Text --- PowerShell cmdlet to displays an argument in a readonly textbox.

## Description

Takes an argument and displays it in a readonly textbox. This cmdlet also creates a button to copy the text to the clipboard.

## Installation

```powershell
git clone https://github.com/hadenpike/Display-Text.git C:/users/<user>/Documents/PowerShell/Modules/Display-Text
```

As long as you cloned this repository to a path specified in $env:PSModulePath, you should be good to go. Otherwise, run
```powershell
Import-Module -Name /path/to/Display-Text
```

## Usage

This function is intended to be used in a pipeline. It accepts the following parameters:
* Text: The text to display.
* Title: The title of the window.

### Examples

```powershell
# Display some text
"this is a test" | Display-Text

# Display some text with a custom title
"this is a test" | Display-Text -Title "Test"
```
