# debug-classic-asp<br>
Debugging class written for Classic ASP, logging events and Try/Catch/Release functions

Use: <br>
Include the _debug.asp file at the beginning of your Classic ASP page, using: <br>
```vbnet
<! -- #include virtual="/folder/_debug.asp" -- >
```

After the class is included, and at the beginning of your code, add: <br>
```vbnet
set Debug = new Debugger
Debug.Initialise(true)
```
Use <b>true</b> to enable the debug mode, or <b>false</b> to disable debug mode.

Available functions: <br>
```vbnet
Debug.Logs(m)
```
m = text string to output as a debugging message.

```vbnet
Debug.Var(m,v)
```
m = text string,<br> 
v = value (string.)<br>
Useful for outputting the value of a variable.

```vbnet
Debug.Try
```
Enable trap.

```vbnet
Debug.Catch
```
Returns: true/false, <br>
Test to trap any errors.

```vbnet
Debug.Release
```
Disable trap.

```vbnet
Debug.Break
```
Stop running the Classic ASP page at this break point.

```vbnet
Debug.Continue(url)
```
If Debug.Mode is true (enabled), then prompt the user if they want to continue, by using the url link. <br>
(This is useful for AJAX pages, which automatically want to return or load another page without pausing.)

```vbnet
set Debug = nothing
```
Close the class and release memory (at the end of your code.)

