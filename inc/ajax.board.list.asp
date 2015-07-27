<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList
Dim cntList   : cntList   = -1
Dim cntTotal  : cntTotal  = 0
Dim pageNo    : pageNo    = CInt(IIF(request("pageNo")="",1,request("pageNo")))
Dim rows      : rows      = IIF( request("rows")="",10,request("rows") )
Dim board_key : board_key = IIF( request("board_key")="",-1 ,request("board_key") )
Dim tab1      : tab1      = IIF( request("tab1")="",0 ,request("tab1") )
Dim tab2      : tab2      = IIF( request("tab2")="",0 ,request("tab2") )
Dim tab3      : tab3      = IIF( request("tab3")="","all",request("tab3") )

Call Expires()
Call dbopen()
	If (board_key="1") Then
		call Check()
	end if
	Call GetList()	
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_L"
		.Parameters("@pageNo").value  = pageNo
		.Parameters("@rows").value    = rows
		.Parameters("@Key").value     = board_key
		.Parameters("@tab").value     = tab1
		.Parameters("@tab2").value    = tab2
		If(tab3="my") Then
		.Parameters("@UserIdx").value = IIF( session("UserIdx")="" ,-1,session("UserIdx") )
		End if
		If(tab1="3" and tab3="all") Then
		.Parameters("@status").value = 2
		End if
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList  = objRs.GetRows()
		cntList  = UBound(arrList, 2)
		cntTotal = arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

Sub Check()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_CHECK"
		.Parameters("@idx").value = IIF( session("UserIdx")="" ,0,session("UserIdx") )
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "CHECK")
	objRs.close	: Set objRs = Nothing
End Sub

Dim xmlStart : xmlStart = "<?xml version=""1.0"" encoding=""utf-8""?><rss version=""2.0""><channel>"
Dim xmlEnd   : xmlEnd   = "</channel></rss>"

dim cnt      : cnt     = "<cnt>" & cntTotal & "</cnt>"
dim btnFg
For iLoop = 0 To cntList
	temp_file = ""

	For i=1 to 10
		fileName = ""
		execute("fileName =" & "arrList(FI_File_name" & IIF(i=1,"",i) &",iLoop)" )

		if fileName <> "" then 
			temp_file = temp_file & "<file>"
			temp_file = temp_file & " <name><![CDATA[" & fileName & "]]></name>"
			
			'다운로드
			If (board_key="1") Then
				
				if session("UserIdx") = "" then
					
					temp_file = temp_file & " <link><![CDATA[javascript:if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')){location.href='../login/?goUrl=" & server.urlencode( g_host & BASE_PATH & "download/" ) & "';}]]></link>"
				else
					If CHECK_CNT = 0 Then
						temp_file = temp_file & " <link><![CDATA[javascript:void(alert('관리자 승인 후 다운로드가 가능합니다.'));]]></link>"
					Else
						temp_file = temp_file & " <link><![CDATA[../download/download.asp?file=" & escape(fileName) & "&idx=" & arrList(FI_idx, iLoop) & "]]></link>"
					End If
				end if
				
			else
				temp_file = temp_file & " <link><![CDATA[../common/download.asp?pach=" & BASE_PATH & "upload/Board/&file=" & escape(fileName) & "]]></link>"
			End if
			
			temp_file = temp_file & "</file>"
		end if
	Next
	
	btnFg = "0"
	if (session("UserIdx") = cstr(arrList(FI_UserIdx, iLoop))) and (arrList(FI_status, iLoop) = "0") then
		btnFg = "1"
	end if

	temp = temp & "<item>"
	temp = temp & "	<no><![CDATA["       & arrList(FI_idx, iLoop)      & "]]></no>"
	temp = temp & "	<rownum><![CDATA["   & arrList(FI_rownum, iLoop)   & "]]></rownum>"
	temp = temp & "	<user><![CDATA["     & arrList(FI_UserIdx, iLoop)  & "]]></user>"
	temp = temp & "	<title><![CDATA["    & arrList(FI_Title, iLoop)    & "]]></title>"
	temp = temp & "	<contants><![CDATA[" & arrList(FI_Contants, iLoop) & "]]></contants>"
	temp = temp & "	<hit><![CDATA["      & arrList(FI_Read_cnt, iLoop) & "]]></hit>"
	temp = temp & "	<created><![CDATA["  & arrList(FI_Indate, iLoop)   & "]]></created>"
	temp = temp & "	<tab1><![CDATA["     & arrList(FI_tab, iLoop)      & "]]></tab1>"
	temp = temp & "	<tab2><![CDATA["     & arrList(FI_tab2, iLoop)     & "]]></tab2>"
	temp = temp & "	<wId><![CDATA["      & arrList(FI_ContId, iLoop)   & "]]></wId>"
	temp = temp & "	<wName><![CDATA["    & arrList(FI_ContName, iLoop) & "]]></wName>"
	temp = temp & "	<btnFg><![CDATA["    & btnFg                       & "]]></btnFg>"
	temp = temp & temp_file
	temp = temp & "</item>"
Next

response.ContentType = "text/xml"
Response.write xmlStart & cnt & temp & xmlEnd
Set objDom = Nothing
%>