# Display-Text.psm1 --- Displays an argument in a readonly textbox.
#
# Author: Haden Pike <haden@hadenpike.net>
#
# Copyright (c) 2025 Haden Pike
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

<#
 .Synopsis
  Displays an argument in a readonly textbox.

 .Description
  Takes an argument and displays it in a readonly textbox. This cmdlet also creates a button to copy the text to the clipboard.

 .Parameter Text
  The text to display.

 .Parameter Title
  The title of the window.

 .Example
  # Display some text
  "this is a test" | Display-Text

 .Example
  # Display some text with a custom title
  "this is a test" | Display-Text -Title "Test"
  #>
function Display-Text {
    [CmdletBinding()]
    Param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $Text,
        [string] $Title = "Display Text"
    )

    begin {
        # Load the necessary assembly for Windows Forms
        Add-Type -AssemblyName System.Windows.Forms
    }

    process {
        $form = New-Object System.Windows.Forms.Form
        $form.Text = $Title
        $form.Size = New-Object System.Drawing.Size(400, 300)

        $textBox = New-Object System.Windows.Forms.TextBox
        $textBox.Location = New-Object System.Drawing.Point(50, 50)
        $textBox.Size = New-Object System.Drawing.Size(300, 150)
        $textBox.Multiline = $true
        $textBox.ReadOnly = $true
        $textBox.Text = $Text

        $copyButton = New-Object System.Windows.Forms.Button
        $copyButton.Location = New-Object System.Drawing.Point(150, 220)
        $copyButton.Size = New-Object System.Drawing.Size(100, 30)
        $copyButton.Text = "Copy to Clipboard"
        $copyButton.Add_Click({
            [System.Windows.Forms.Clipboard]::SetText($textBox.Text.Trim())
        })

        $form.Controls.Add($textBox)
        $form.Controls.Add($copyButton)

        $form.ShowDialog()
    }
}

Export-ModuleMember -Function Display-Text
