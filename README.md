# debug-classic-asp<br>
Debugging class written for Classic ASP, logging events and Try/Catch/Release functions

Use: <br>
Include the _debug.asp file at the beginning of your Classic ASP page, using: <br>
<code><! -- #include virtual="/folder/_debug.asp" -- ></code>

After the class is included, and at the beginning of your code, add: <br>
<code>set Debug = new Debugger</code><br>
<code>Debug.Initialise(true)</code><br>
Use <b>true</b> to enable the debug mode, or <b>false</b> to disable debug mode.

Available functions: <br>
<code>Debug.Logs(m)</code><br>
  m = text string to output as a debugging message.

<code>Debug.Var(m,v)</code><br>
  m = text string,<br> 
  v = value (string.)<br>
  Useful for outputting the value of a variable.

<code>Debug.Try</code><br>
  Enable trap.

<code>Debug.Catch</code><br>
  Returns: true/false, <br>
  Test to trap any errors.

<code>Debug.Release</code><br>
  Disable trap.

<code>Debug.Break</code><br>
  Stop running the Classic ASP page at this break point.

<code>Debug.Continue(url)</code><br>
  If Debug.Mode is true (enabled), then prompt the user if they want to continue, by using the url link. <br>
  (This is useful for AJAX pages, which automatically want to return or load another page without pausing.)

<code>set Debug = nothing</code><br>
  Close the class and release memory (at the end of your code.)
