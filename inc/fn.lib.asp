<%

Function checkLogin(url)
	If session("userId")="" or IsNull(session("userId"))=True Then 
		response.redirect "../login/?goUrl="&server.urlencode(url &  "?" & Request.ServerVariables("QUERY_STRING") )
	End If
End Function

'------------------------------------------------------------------------------------
' 페이징
'------------------------------------------------------------------------------------
Function printPageList(pTotCount, pPageNo, pRows, url)
	if pTotCount = 0 then 
		printPageList = "<a class=""prev_off""><span class=""blind"">이전</span></a><a class=""on"">1</a><a class=""next_off""><span class=""blind"">다음</span></a>"	: Exit Function
	end if
	
	' 하단에 보여줄 페이지 건수...
	Dim tPrintCount, tPageCount, tCurRange, tCount, tPageNo
	Dim tmpStr
	
	tPrintCount = 10
	tPageCount = Fix((pTotCount + (pRows-1)) / pRows)
	tCurRange  = FIX((pPageNo-1) / tPrintCount)* tPrintCount

	tCount = 1
	tPageNo = 0
	
	' 두단계 앞으로....
	tmpStr = ""
	if ( tCurRange > 0) then
		tmpStr = tmpStr & ""
	else
		tmpStr = tmpStr & ""
	end if
	
	' 한단계 앞으로....
	if ( tCurRange > 0) then
		tmpStr = tmpStr & "<a href=""" & replace(url,"__PAGE__",(tCurRange-tPrintCount+1)) & """ class=""prev""><span class=""blind"">이전</span></a>"
	else
		tmpStr = tmpStr & "<a class=""prev_off""><span class=""blind"">이전</span></a>"
	end if

	while (tCount <= tPrintCount AND (tCurRange+tCount) <= tPageCount )
		tPageNo = tCurRange+tCount

		if (tPageNo = pPageNo)	then
			tmpStr = tmpStr & "<a class=""on"">" & tPageNo & "</a>"
		else
			tmpStr = tmpStr & "<a href='" & replace(url,"__PAGE__",tPageNo) & "'>" & tPageNo & "</a>"
		end if
		
		tCount = tCount + 1
	wend
	
	' 한단계 뒤로....
	if ( FIX((tPageCount-1)/tPrintCount) > FIX(tCurRange/tPrintCount) )	then
		tmpStr = tmpStr & "<a href=""" & replace(url,"__PAGE__",(tCurRange+tPrintCount+1)) & """ class=""next""><span class=""blind"">다음</span></a>"
	else
		tmpStr = tmpStr & "<a class=""next_off""><span class=""blind"">다음</span></a>"
	end if
	
	' 두단계 뒤로....
	if ( FIX((tPageCount-1)/tPrintCount) > FIX(tCurRange/tPrintCount) )	then
		tmpStr = tmpStr & ""
	else
		tmpStr = tmpStr & ""
	end if
	
	printPageList = tmpStr
	
End Function
%>