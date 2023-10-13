<%

'// AUTHOR: Simon Beal
'// UPDATE: 2021-09-28 / 2016-07-22

'// REQUIRES:	/debug-classic-asp/_debugcss.asp
'//		/debug-classic-asp/_debug.css

'// USAGE: 
'// 	set Debug = new Debugger
'// 	Debug.Initialise(true)

dim Debug

class Debugger

	public Mode
	public Terminate
	public Suffix
	public Override
	public Hide
	private Logbook

	public function Initialise(byval binMode)

		if binMode = true then 
			Mode = true

			response.buffer = true
			on error resume next
			err.clear

			'// INSERT DEBUG CSS (STYLESHEET)
			server.execute("/debug-classic-asp/_debugcss.asp")

			Logs("Initiated Debug Mode.")
		else
			Mode = false
		end if

		Logbook = ""
		Suffix = false
		Override = false
		Hide = false

	end function

	public function Requests()

		dim str, strItem

		Logs("REQUEST.FORM")

		For Each strItem In Request.Form
			str = strItem
			str = str & " = [" & Request.Form(strItem) & "]"
			Logs(str)
		Next

		Logs("REQUEST.QUERYSTRING")

		For Each strItem In Request.QueryString
			str = strItem
			str = str & " = [" & Request.QueryString(strItem) & "]"
			Logs(str)
		Next

	end function

	public function IsError(byval errorMsg)

		if Mode = true and err.number <> 0 Then
			Logs(errorMsg)
		end if

		if Terminate = true then StopRunning(true)

	end function

	public sub Var(byval text, byval value)

		Logs(text & " = [" & value & "]")

	end sub

	public function Logs(byval msg)

		msg = Server.HTMLEncode(msg)

		dim temp
		dim characterPosition
		dim endOfLine

		if Hide = false and (Mode = true or Override = true) then

			if 	ucase(left(msg, 7)) = "SELECT " or _
				ucase(left(msg, 7)) = "UPDATE " or _
				ucase(left(msg, 7)) = "DELETE " or _
				ucase(left(msg, 7)) = "INSERT " then
				msg = "<blockquote>" & msg & "</blockquote><div class='clr'></div>"
				temp = "<br>"
			else
				characterPosition = instr(msg, "= [")
				if characterPosition > 1 then
					characterPosition = instr(characterPosition + 1, msg, "= [")
					if characterPosition > 0 then
						temp = "<br>"
					else
						temp = ""
					end if
				end if
			end if

			if err.number = 0 then
				Render("<div id='debugBox'>" & temp)
			else
				Render("<div id='debugBox' class='bg'># {" & err & "} " & err.description & "; " & temp)
			end if

			if len(msg) > 0 then
				msg = replace(msg, chr(9), "")
				characterPosition 	= instr(msg, "= [")
			else
				characterPosition = 0
			end if

			while characterPosition > 1

				Render("<span class='debugLeft'>" & left(msg,characterPosition - 1) & "</span>")
				msg = mid(msg, characterPosition + 1)
				endOfLine = instr(msg, "]")

				if endOfLine > 0 then
					Render("<span class='debugRight'>" & left(msg, endOfLine) & "</span><br>")
					if len(msg) > endOfLine then
						msg = mid(msg, endOfLine + 1)
					else
						msg = ""
					end if
					endOfLine = 0
				end if

				characterPosition = instr(msg, "= [")
			wend

			if len(msg) > 0 then Render(msg)

			Render("</div>")
			Render("<div class='clr'></div>")

			if err.number <> 0 then
				Terminate = true
				err.clear
			end if

			response.flush
		end if

	end function

	public sub Break()

		if Mode = true or Override = true then

			Render(	"<blockquote>" & _
						"<p>Stopped at " & now() & "</p>" & _
						"</blockquote>")

			response.flush
			response.end
		end if

	end sub

	public function StopRunning(confirm)

		if 	(Mode = true or Override = true) and _
			confirm = true and _
			Terminate = true then
			
			Render(	"<blockquote>" & _
					"<p>Stopped at " & now() & "</p>" & _
					"</blockquote>")

			response.flush
			response.end
		end if

	end function

	public function Continue(byval url)

		if url = "" then url = "/"

		if Mode = true or Override = true then
			Render(	"<blockquote>" & _
					"Stopped at " & now() & ". Would you like to <a href='" & url & "'>Continue</a>? " & _
					"</blockquote>")
		else
			response.redirect(url)
		end if

	end function

	public function Output()

		if Suffix = true then
			Suffix = false
			Render(Logbook)
		end if

	end function

	public function Render(byval msg)

		if Suffix = false then
			'// WRITE HTML STRING TO DOCUMENT'
			response.write replace(msg, chr(9), "") & vbcrlf
		else
			Logbook = Logbook & replace(msg, chr(9), "") & vbcrlf
		end if

	end function

	public sub Try()
		'// ENABLE ERROR TRY/CATCH HANDLER

		err.clear
		on error resume next
	end sub

	public function Catch()
		'// CATCH ERRORS

		if err.number <> 0 then
			Catch = true
		else
			Catch = false
		end if
	end function

	public sub Release()
		'// RELEASE ERROR BUT MAINTAIN TRAP'

		err.clear
		if Mode = false then 
			on error goto 0
		end if
	end sub

end class

%>
