<?xml version="1.0" encoding="utf-8" ?>
<!-- #include file = "../inc/header.asp" -->
<%response.ContentType = "text/xml"%>
<%
Dim arrList
Dim cntList    : cntList  = -1
Dim cntTotal   : cntTotal = 0
Dim rows       : rows     = 20
Dim pageNo     : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserName   : UserName = request("UserName")
Dim UserId     : UserId   = request("UserId")
Dim Hphone3    : Hphone3  = request("Hphone3")
Dim delFg      : delFg    = request("delFg")
Dim State      : State    = request("State")
Dim ceoFg      : ceoFg    = request("ceoFg")
Dim companyIdx : companyIdx = request("companyIdx")
Dim Indate     : Indate   = request("Indate")
Dim Outdate    : Outdate  = request("Outdate")


Dim DataMsg : DataMsg = "<data><admin_login>login</admin_login></data>"

If Session("Admin_Idx") <> "" Then
	Call Expires()
	Call dbopen()
		Call GetList()
	Call dbclose()
	
	PageListNum = printNextPage(cntTotal, pageNo, rows)

	DataMsg = "<data>"
	DataMsg = DataMsg &  "<admin_login>success</admin_login>"
	DataMsg = DataMsg &  "<PageListNum>" & PageListNum & "</PageListNum>"


	for iLoop = 0 to cntList

		If arrList(FI_state,iLoop) = "0" Then 
			stateTxt = "관리자승인완료"
		ElseIf arrList(FI_state,iLoop) = "1" Then
			stateTxt = "<font color=red>승인요청</font>"
		ElseIf arrList(FI_state,iLoop) = "2" Then
			stateTxt = "<font color=blue>대표자승인완료</font>"
		ElseIf arrList(FI_state,iLoop) = "3" Then
			stateTxt = "<font color=green>대표자 인증전</font>"
		Else
			stateTxt = ""
		End If
		
		tmp_UserId    = arrList(FI_UserId,iLoop)
		tmp_UserEmail = arrList(FI_UserEmail,iLoop)
		tmp_UserId    = IIF( isValidEmail(tmp_UserId),tmp_UserId, tmp_UserId &"<div style='color:#777777;'>[ "& tmp_UserEmail & " ]</div> " )

		DataMsg = DataMsg &  "<item>"		
		DataMsg = DataMsg &  "<UserIdx><![CDATA["    & Trim( arrList(FI_UserIdx, iLoop) )                  & "]]></UserIdx>"
		DataMsg = DataMsg &  "<rownum><![CDATA["     & Trim( arrList(FI_rownum,iLoop) )                    & "]]></rownum>"
		DataMsg = DataMsg &  "<ceo><![CDATA["        & Trim( IIF( arrList(FI_ceo,iLoop)="1" , "v" , "" ) ) & "]]></ceo>"
		DataMsg = DataMsg &  "<UserIndate><![CDATA[" & Trim( arrList(FI_UserIndate,iLoop) )                & "]]></UserIndate>"
		DataMsg = DataMsg &  "<UserName><![CDATA["   & Trim( arrList(FI_UserName,iLoop) &" "& arrList(FI_UserNameLast,iLoop) ) & "]]></UserName>"
		DataMsg = DataMsg &  "<UserId><![CDATA["     & Trim( tmp_UserId )                                                      & "]]></UserId>"
		DataMsg = DataMsg &  "<stateTxt><![CDATA["   & Trim( stateTxt )                                                        & "]]></stateTxt>"
		DataMsg = DataMsg &  "<UserDelFg><![CDATA["  & Trim( IIF( arrList(FI_UserDelFg,iLoop)="0","사용중","<font color=red>탈퇴</font>" ) ) & "]]></UserDelFg>"
		DataMsg = DataMsg &  "</item>"

	next

	DataMsg = DataMsg &  "</data>"

End If

Response.write DataMsg

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_L"
		.Parameters("@rows").value       = rows 
		.Parameters("@pageNo").value     = pageNo
		.Parameters("@UserName").value   = UserName
		.Parameters("@UserId").value     = UserId
		.Parameters("@Hphone3").value    = Hphone3
		.Parameters("@delFg").value      = delFg
		.Parameters("@State").value      = State
		.Parameters("@companyIdx").value = companyIdx
		.Parameters("@Indate").value     = Indate
		.Parameters("@Outdate").value    = Outdate
		.Parameters("@ceoFg").value      = ceoFg
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub


Function printNextPage(pTotCount, pPageNo, pRows)
	
	' 하단에 보여줄 페이지 건수...
	Dim tPrintCount, tPageCount, tCurRange
	Dim tmpStr
	
	tPrintCount = 10
	tPageCount = Fix((pTotCount + (pRows-1)) / pRows)
	tCurRange  = FIX((pPageNo-1) / tPrintCount)* tPrintCount

	If tPageCount <= pPageNo Then 
		tmpStr = 0
	Else 
		tmpStr = pPageNo + 1
	End If

	printNextPage = tmpStr
	
End Function


%>