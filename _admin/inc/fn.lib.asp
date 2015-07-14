<%
'------------------------------------------------------------------------------------
' Admin 메뉴설정
'------------------------------------------------------------------------------------
Dim AdminLeftName,AdminTopmode

If INSTR(LCase(g_url),"/admin/")>0 Then
	AdminLeftName = "홈페이지관리"
	AdminTopmode  = 1
elseIf INSTR(LCase(g_url),"/info/")>0 Then 
	AdminLeftName = "시설안내관리"
	AdminTopmode  = 2
elseIf INSTR(LCase(g_url),"/golfer/")>0 Then 
	AdminLeftName = "프로골퍼관리"
	AdminTopmode  = 3
elseIf INSTR(LCase(g_url),"/member/")>0 Then 
	AdminLeftName = "회원관리"
	AdminTopmode  = 4
elseIf INSTR(LCase(g_url),"/customer/")>0 Then 
	AdminLeftName = "게시판관리"
	AdminTopmode  = 5
End If
'------------------------------------------------------------------------------------
'' 관리자 로그인 체크.
'------------------------------------------------------------------------------------
Function checkAdminLogin(url)
	If session("Admin_Id")="" or IsNull(session("Admin_Id"))=True Then 
		response.redirect "../index.asp?GoUrl=" & server.urlencode(url)
	End If
End Function


'기초코드 배열반환 
Function fc_code_list(idx)
	Call Expires()
	Call dbopen()

	Dim arrList
	Dim tmp_txt
	Dim cntList  : cntList  = -1

	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "KETI_COMM_CODE2_P"
		.Parameters("@actType").value = "VIEW"
		.Parameters("@PIdx").value    = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing

	For iLoop = 0 To cntList
		tmp_txt = tmp_txt & arrList(FI_Idx,iLoop) & "|_KEY_|" & TagDecode( arrList(FI_Name,iLoop) )
		If iLoop < cntList Then 
			tmp_txt = tmp_txt &  "|_ARRY_|"
		End If
	Next
	Call dbclose()
	fc_code_list = tmp_txt
End Function

'------------------------------------------------------------------------------------
' 페이징
'------------------------------------------------------------------------------------
Function printPageList(pTotCount, pPageNo, pRows, url)
	if pTotCount = 0 then 
		printPageList = "<span class='bold'>1</span>"	: Exit Function
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
		tmpStr = tmpStr & vbCrLf & "◀ <a href='" & replace(url,"__PAGE__","1") & "'>처음</a> |"
	else
		tmpStr = tmpStr & vbCrLf & ""
	end if
	
	' 한단계 앞으로....
	if ( tCurRange > 0) then
		tmpStr = tmpStr & vbCrLf & "◁ <a href='" & replace(url,"__PAGE__",(tCurRange-tPrintCount+1)) & "'>이전</a> |"
	else
		tmpStr = tmpStr & vbCrLf & ""
	end if

	while (tCount <= tPrintCount AND (tCurRange+tCount) <= tPageCount )
		tPageNo = tCurRange+tCount

		if (tPageNo = pPageNo)	then
			tmpStr = tmpStr & vbCrLf & "<b>" & tPageNo & "</b> |"
		else
			tmpStr = tmpStr & vbCrLf & "<a href='" & replace(url,"__PAGE__",tPageNo) & "'>" & tPageNo & "</a> |"
		end if
		
		tCount = tCount + 1
	wend
	
	' 한단계 뒤로....
	if ( FIX((tPageCount-1)/tPrintCount) > FIX(tCurRange/tPrintCount) )	then
		tmpStr = tmpStr & vbCrLf & "<a href='" & replace(url,"__PAGE__",(tCurRange+tPrintCount+1)) & "' class='next'>다음</a> ▷ |"
	else
		tmpStr = tmpStr & vbCrLf & ""
	end if
	
	' 두단계 뒤로....
	if ( FIX((tPageCount-1)/tPrintCount) > FIX(tCurRange/tPrintCount) )	then
		tmpStr = tmpStr & vbCrLf & "<a href='" & replace(url,"__PAGE__",tPageCount) & "' class='last'>끝 </a> ▶"
	else
		tmpStr = tmpStr & vbCrLf & ""
	end if
	
	printPageList = tmpStr
	
End Function
%>