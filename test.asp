<!-- #include virtual="/debug-classic-asp/_debug.asp" -->
<%

set Debug = new Debugger
Debug.Initialise(true)
Debug.Suffix = false

Debug.Logs "Hello, world!"

Debug.Var "Date/time",now

Debug.Try

if Debug.Catch then
	'// CAUGHT AN ERROR
end if

Debug.Release

set Debug = nothing

%>
