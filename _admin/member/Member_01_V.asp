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
		DataMsg = "<data>"
		DataMsg = DataMsg &  "<admin_login>success</admin_login>"
		DataMsg = DataMsg &  "<item>"
		DataMsg = DataMsg &  "<UserIdx><![CDATA["         & Trim( FI_UserIdx )                 & "]]></UserIdx>"
		DataMsg = DataMsg &  "<UserId><![CDATA["          & Trim( FI_UserId )                  & "]]></UserId>"
		DataMsg = DataMsg &  "<UserName><![CDATA["        & Trim( FI_UserName )                & "]]></UserName>"
		DataMsg = DataMsg &  "<UserHPhone0><![CDATA["     & Trim( FI_UserHPhone0 )             & "]]></UserHPhone0>"
		DataMsg = DataMsg &  "<UserHPhone1><![CDATA["     & Trim( FI_UserHPhone1 )             & "]]></UserHPhone1>"
		DataMsg = DataMsg &  "<UserHPhone2><![CDATA["     & Trim( FI_UserHPhone2 )             & "]]></UserHPhone2>"
		DataMsg = DataMsg &  "<UserHPhone3><![CDATA["     & Trim( FI_UserHPhone3 )             & "]]></UserHPhone3>"
		DataMsg = DataMsg &  "<UserPhone1><![CDATA["      & Trim( FI_UserPhone1 )              & "]]></UserPhone1>"
		DataMsg = DataMsg &  "<UserPhone2><![CDATA["      & Trim( FI_UserPhone2 )              & "]]></UserPhone2>"
		DataMsg = DataMsg &  "<UserPhone3><![CDATA["      & Trim( FI_UserPhone3 )              & "]]></UserPhone3>"
		DataMsg = DataMsg &  "<UserFax1><![CDATA["        & Trim( FI_UserFax1 )                & "]]></UserFax1>"
		DataMsg = DataMsg &  "<UserFax2><![CDATA["        & Trim( FI_UserFax2 )                & "]]></UserFax2>"
		DataMsg = DataMsg &  "<UserFax3><![CDATA["        & Trim( FI_UserFax3 )                & "]]></UserFax3>"
		DataMsg = DataMsg &  "<UserEmail1><![CDATA["      & Trim( Split(FI_UserEmail,"@")(0) ) & "]]></UserEmail1>"
		DataMsg = DataMsg &  "<UserEmail2><![CDATA["      & Trim( Split(FI_UserEmail,"@")(1) ) & "]]></UserEmail2>"
		DataMsg = DataMsg &  "<UserZipcode1><![CDATA["    & Trim( Left(FI_UserZipcode,3) )     & "]]></UserZipcode1>"
		DataMsg = DataMsg &  "<UserZipcode2><![CDATA["    & Trim( Right(FI_UserZipcode,3) )    & "]]></UserZipcode2>"
		DataMsg = DataMsg &  "<UserAddr1><![CDATA["       & Trim( FI_UserAddr1 )               & "]]></UserAddr1>"
		DataMsg = DataMsg &  "<UserAddr2><![CDATA["       & Trim( FI_UserAddr2 )               & "]]></UserAddr2>"
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