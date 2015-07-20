<?xml version="1.0" encoding="utf-8" ?>
<!-- #include file = "../inc/header.asp" -->
<%response.ContentType = "text/xml"%>
<%
Dim DataMsg : DataMsg = "<data><admin_login>login</admin_login></data>"
Dim UserIdx : UserIdx = IIF(Request.Form("user_idx")="",0,Request.Form("user_idx"))

Dim arrList
Dim cntList : cntList  = -1

If Session("Admin_Idx") <> "" Then
	Call Expires()
	Call dbopen()
		Call GetList()
		Call getView()
		'전화번호,휴대폰 번호 
		UserHPhone = IIF( FI_UserHPhone="",FI_UserHPhone1 &"-"& FI_UserHPhone2 &"-"& FI_UserHPhone3,FI_UserHPhone )
		UserPhone  = IIF( FI_UserPhone="",FI_UserPhone1 &"-"& FI_UserPhone2 &"-"& FI_UserPhone3,FI_UserPhone )
		UserEmail  = IIF( isValidEmail(FI_UserId),"", FI_UserEmail )

		DataMsg = "<data>"
		DataMsg = DataMsg &  "<admin_login>success</admin_login>"
		DataMsg = DataMsg &  "<item>"
		DataMsg = DataMsg &  "<UserIdx><![CDATA["         & Trim( FI_UserIdx )                 & "]]></UserIdx>"
		DataMsg = DataMsg &  "<UserId><![CDATA["          & Trim( FI_UserId )                  & "]]></UserId>"
		DataMsg = DataMsg &  "<UserName><![CDATA["        & Trim( FI_UserName )                & "]]></UserName>"
		DataMsg = DataMsg &  "<UserNameLast><![CDATA["    & Trim( FI_UserNameLast )            & "]]></UserNameLast>"
		DataMsg = DataMsg &  "<UserHPhone><![CDATA["      & Trim( UserHPhone )                 & "]]></UserHPhone>"
		DataMsg = DataMsg &  "<UserPhone><![CDATA["       & Trim( UserPhone )                  & "]]></UserPhone>"
		DataMsg = DataMsg &  "<UserEmail><![CDATA["       & Trim( UserEmail )                  & "]]></UserEmail>"
		DataMsg = DataMsg &  "<UserIndate><![CDATA["      & Trim( FI_UserIndate )              & "]]></UserIndate>"
		DataMsg = DataMsg &  "<UserIndate_full><![CDATA[" & Trim( FI_UserIndate_full )         & "]]></UserIndate_full>"
		DataMsg = DataMsg &  "<UserOutdate><![CDATA["     & Trim( FI_UserOutdate )             & "]]></UserOutdate>"
		DataMsg = DataMsg &  "<UserDelFg><![CDATA["       & Trim( FI_UserDelFg )               & "]]></UserDelFg>"
		DataMsg = DataMsg &  "<UserEmailFg><![CDATA["     & Trim( FI_UserEmailFg )             & "]]></UserEmailFg>"
		DataMsg = DataMsg &  "<UserBigo><![CDATA["        & TagDecode(Trim( FI_UserBigo ))     & "]]></UserBigo>"
		DataMsg = DataMsg &  "<state><![CDATA["           & Trim( FI_state )                   & "]]></state>"
		DataMsg = DataMsg &  "<ceoFg><![CDATA["           & Trim( FI_ceo )                     & "]]></ceoFg>"
		DataMsg = DataMsg &  "<companyIdx><![CDATA["      & Trim( FI_companyIdx )              & "]]></companyIdx>"
		DataMsg = DataMsg &  "<UserPosition><![CDATA["    & Trim( FI_UserPosition )            & "]]></UserPosition>"
		DataMsg = DataMsg &  "</item>"
		for iLoop = 0 to cntList
			DataMsg = DataMsg &  "<coCode>"
			DataMsg = DataMsg &  "<idx><![CDATA["   & arrList(CO_idx,iLoop)   & "]]></idx>"
			DataMsg = DataMsg &  "<cName><![CDATA[" & arrList(CO_cName,iLoop) & "]]></cName>"
			DataMsg = DataMsg &  "</coCode>"
		Next
		DataMsg = DataMsg &  "</data>"
	Call dbclose()
End If

Response.write DataMsg

Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_L"
		.Parameters("@UserIdx").value  = UserIdx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_MINI_L"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "CO")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>