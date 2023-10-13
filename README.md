# debug-classic-asp
Debugging class written for Classic ASP, logging events and Try/Catch/Release functions

Use: 
Include the _debug.asp file at the beginning of your Classic ASP page, using: <!-- #include virtual="/folder/_debug.asp" -->

After the class is included, and at the beginning of your code segment(s), add: 
  set Debug = new Debugger
  Debug.Initialise(true)

Use the (true) or (false) to enabled/disable the debug mode.

Available functions: 
Debug.Logs(m)
  m = text string to output as a debugging message.

Debug.Var(m,v)
  m = text string, 
  v = value (string.)
  Useful for outputting the value of a variable.

Debug.Try
  Enable trap.

Debug.Catch
  Returns: true/false, 
  Test to trap any errors.

Debug.Release
  Disable trap.

Debug.Break
  Stop running the Classic ASP page at this break point.

Debug.Continue(url)
  If Debug.Mode is true (enabled), then prompt the user if they want to continue, by using the url link. 
  (This is useful for AJAX pages, which automatically want to return or load another page without pausing.)

set Debug = nothing
  Close the class and release memory.
