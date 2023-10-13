# debug-classic-asp<br>
Debugging class written for Classic ASP, logging events and Try/Catch/Release functions

Use: <br>
Include the _debug.asp file at the beginning of your Classic ASP page, using: <code><! -- #include virtual="/folder/_debug.asp" -- ></code>

After the class is included, and at the beginning of your code segment(s), add: <br>
<code>set Debug = new Debugger<br>
Debug.Initialise(true)</code>

Use the (true) or (false) to enabled/disable the debug mode.

Available functions: <br>
Debug.Logs(m)<br>
  m = text string to output as a debugging message.

Debug.Var(m,v)<br>
  m = text string,<br> 
  v = value (string.)<br>
  Useful for outputting the value of a variable.

Debug.Try<br>
  Enable trap.

Debug.Catch<br>
  Returns: true/false, <br>
  Test to trap any errors.

Debug.Release<br>
  Disable trap.

Debug.Break<br>
  Stop running the Classic ASP page at this break point.

Debug.Continue(url)<br>
  If Debug.Mode is true (enabled), then prompt the user if they want to continue, by using the url link. <br>
  (This is useful for AJAX pages, which automatically want to return or load another page without pausing.)

set Debug = nothing<br>
  Close the class and release memory.
