<%
function setCodeOption(optionKey , htmlType , value , selecter )
	Dim arrList  , html , setValue , checked
	Dim cntList  : cntList  = -1

	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "ocean_COMM_CODE2_P"
		.Parameters("@actType").value  = "VIEW"
		.Parameters("@PIdx").value      = optionKey
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldIndex(objRs, "OPTION")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing

	for iLoop = 0 to cntList
		checked = ""
		If value = 0 Then 
			setValue = cstr(arrList(OPTION_idx, iLoop))
		Else
			setValue = arrList(OPTION_name, iLoop)
		End If
		
		If htmlType = "select" Then 
			If setValue = selecter Then
				checked = "selected"
			End If
			html = html & "<option value=""" & setValue & """ "&checked&">" & arrList(OPTION_name, iLoop) & "</option>"
		ElseIf htmlType = "checkbox" Then 
			If setValue = selecter Then
				checked = "checked"
			End If
			html = html & "<input type=""checkbox"" name=""" & optionKey & """ value=""" & setValue & """ "&checked&"> " & arrList(OPTION_name, iLoop)
		ElseIf htmlType = "radio" Then 
			If setValue = selecter Then
				checked = "selected"
			End If
			html = html & "<input type=""radio"" name=""" & optionKey & """ value=""" & setValue & """ "&checked&"> " & arrList(OPTION_name, iLoop)
		End If
	Next

	setCodeOption = html	
End Function



function sendSmsEmail( actType , userId , userEmail , contants , attachPath )
	Dim strFile,strTitle

	If actType = "join" Then 
		strFile = server.mapPath("/ocean/common/mailform/join.html")
		strTitle = "[OCEAN 고객센터] 회원가입이 완료되었습니다."
	ElseIf actType = "join_ceo" Then 
		strFile = server.mapPath("/ocean/common/mailform/join_ceo.html")
		strTitle = "[OCEAN 고객센터] 회원가입이 신청되었습니다."
	ElseIf actType = "join_staff" Then 
		strFile = server.mapPath("/ocean/common/mailform/join_staff.html")
		strTitle = "[OCEAN 고객센터] 회원가입이 신청되었습니다."
	ElseIf actType = "id_search" Then 
		strFile = server.mapPath("/ocean/common/mailform/id_search.html")
		strTitle = "[OCEAN 고객센터] 요청하신 아이디를 알려드립니다."
	ElseIf actType = "pwd_search" Then 
		strFile = server.mapPath("/ocean/common/mailform/pwd_search.html")
		strTitle = "[OCEAN 고객센터] 요청하신 비밀번호를 알려드립니다."
	ElseIf actType = "pwd_change" Then 
		strFile = server.mapPath("/ocean/common/mailform/pwd_change.html")
		strTitle = "[OCEAN 고객센터] 고객님의 비밀번호가 변경되었습니다."
	ElseIf actType = "email" Then 
		strFile = server.mapPath("/ocean/common/mailform/mail_change.html")
		strTitle = "[OCEAN 고객센터] 고객님의 이메일이 변경되었습니다."
	ElseIf actType = "secede" Then 
		strFile = server.mapPath("/ocean/common/mailform/secede.html")
		strTitle = "[OCEAN 고객센터] 회원 탈퇴가 성공적으로 이루어졌습니다."
	End If

	Dim mfrom		: mfrom		= "OCEAN<araha@keti.re.kr>"
	Dim mto			: mto		= userEmail
	Dim mtitle		: mtitle	= strTitle
	Dim mcontents	: mcontents	= ReadFile(strFile)
		
	mcontents = replace(mcontents, "#ID#"      , userId )
	mcontents = replace(mcontents, "#EMAIL#"   , userEmail )
	mcontents = replace(mcontents, "#CONTANTS#", contants )

	Dim mailMessage : mailMessage = MailSend(mtitle, mcontents, mto, mfrom, attachPath)
	sendSmsEmail = mailMessage
End Function

function sendSmsEmail_state( actType , userEmail , company , kind , position , name , phone , contants , attachPath )
	Dim strFile,strTitle

	If actType = "join_state_admin" Then 
		strFile = server.mapPath("/ocean/common/mailform/join_state_admin.html")
		strTitle = "[OCEAN 고객센터] 회원가입 신청자 승인요청안내"

	ElseIf actType = "join_state_ceo" Then 
		strFile = server.mapPath("/ocean/common/mailform/join_state_ceo.html")
		strTitle = "[OCEAN 고객센터] 회원가입 신청자 승인요청안내"
	End If

	Dim mfrom		: mfrom		= "OCEAN<araha@keti.re.kr>"
	Dim mto			: mto		= userEmail
	Dim mtitle		: mtitle	= strTitle
	Dim mcontents	: mcontents	= ReadFile(strFile)

	mcontents = replace(mcontents, "#COMPANY#" , company )
	mcontents = replace(mcontents, "#KIND#"    , kind )
	mcontents = replace(mcontents, "#POSITION#", position )
	mcontents = replace(mcontents, "#NAME#"    , name )
	mcontents = replace(mcontents, "#PHONE#"   , phone )
	mcontents = replace(mcontents, "#CONTANTS#", contants )

	Dim mailMessage : mailMessage = MailSend(mtitle, mcontents, mto, mfrom, attachPath)
	sendSmsEmail_state = mailMessage
End function
'** ---------------------------------------------------------------------------
' 함 수 명 : MailSend(strSubject, strBody, strTo, strFrom)
' 인    자 : 1. strSubject	: 메일 제목
'            2. strBody		: 메일 내용
'            3. strTo		: 받는 사람 메일 주소
'            4. strFrom		: 보내는 사람 메일 주소
' 목    적 : 메일 발송
'** ---------------------------------------------------------------------------
function MailSend(strSubject, strBody, strTo, strFrom, attachPath)
	dim result
	Dim objConfig, objSendMail, Flds

	on error resume Next
	
	Const cdoSendUsingMethod		= "http://schemas.microsoft.com/cdo/configuration/sendusing" 
	Const cdoSendUsingPort			= 1  ' 1:로컬, 1:외부
	Const cdoSMTPServer				= "http://schemas.microsoft.com/cdo/configuration/smtpserver" 
	Const cdoSMTPServerPort			= "http://schemas.microsoft.com/cdo/configuration/smtpserverport"
	Const cdoSMTPConnectionTimeout	= "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" 
	Const cdoSMTPAccountName		= "http://schemas.microsoft.com/cdo/configuration/smtpaccountname" 
	Const cdoSMTPAuthenticate		= "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate" 
	Const cdoSMTPPickupDirectory	= "http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory" 
	Const cdoBasic					= 1 
	Const cdoSendUserName			= "http://schemas.microsoft.com/cdo/configuration/sendusername" 
	Const cdoSendPassword			= "http://schemas.microsoft.com/cdo/configuration/sendpassword" 

	' SMTP Configuration 
	set objConfig = createobject("CDO.Configuration") 
	Set Flds = objConfig.Fields 
	With Flds 
		.Item(cdoSendUsingMethod) = cdoSendUsingPort 
		.Item(cdoSMTPServer) = "127.0.0.1"  ' 로컬호스트 
		.Item(cdoSMTPServerPort) = 25 
		.Item(cdoSMTPAuthenticate) = cdoBasic 
		.Item(cdoSMTPPickupDirectory) = "C:\Inetpub\mailroot\Pickup"  ' 픽업 디렉토리 경로 지정
		'.Item(cdoSendUserName) = "계정 id"
		'.Item(cdoSendPassword) = "계정 pwd"
		.Update
	End With 
	
	Set objSendMail = Server.CreateObject("CDO.Message")
	With objSendMail 
		.BodyPart.Charset = "ks_c_5601-1987" 
		.Configuration = objConfig 
		'.MimeFormatted = false 
		.From		= strFrom
		.To			= strTo
		.Subject	= strSubject
		.HTMLBody	= strBody
		if LEN(attachPath)>0 then
			.AddAttachment attachPath
		end if
		.fields.update 
		.Send
	End With

	Set objSendMail = Nothing

	if err.number <> 0 then
		result = replace(replace(replace(err.description,vbCrLf,""),vbCr,""),vbLf,"")
	else
		result = "ok"
	end if

	MailSend = result
end function


'** ---------------------------------------------------------------------------
' 함 수 명 : ReadFile(strFileName)
' 인  자 : 1. strFileName : 파일명
' 목    적 : 파일 읽기
'** ---------------------------------------------------------------------------
function ReadFile(strFileName)
	Dim objStream
	Set objStream = CreateObject("ADODB.Stream")
	objStream.CharSet = "utf-8"
	objStream.Open
	objStream.LoadFromFile(strFileName)
	ReadFile = objStream.ReadText()
end Function


'----------------------------------------------------------------------------------------------
' 문자열 64비트 디코드
'----------------------------------------------------------------------------------------------
function Base64decode(ByVal asContents)
Const sBASE_64_CHARACTERS = _
           "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" 
           Dim lsResult
           Dim lnPosition
           Dim lsGroup64, lsGroupBinary
           Dim Char1, Char2, Char3, Char4
           Dim Byte1, Byte2, Byte3
           if Len(asContents) Mod 4 > 0 _
          Then asContents = asContents & String(4 - (Len(asContents) Mod 4), " ")
           lsResult = ""

           For lnPosition = 1 To Len(asContents) Step 4
                   lsGroupBinary = ""
                   lsGroup64 = Mid(asContents, lnPosition, 4)
                   Char1 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 1, 1)) - 1
                   Char2 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 2, 1)) - 1
                   Char3 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 3, 1)) - 1
                   Char4 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 4, 1)) - 1
                   Byte1 = Chr(((Char2 And 48) \ 16) Or (Char1 * 4) And &HFF)
                   Byte2 = lsGroupBinary & Chr(((Char3 And 60) \ 4) Or (Char2 * 16) And &HFF)
                   Byte3 = Chr((((Char3 And 3) * 64) And &HFF) Or (Char4 And 63))
                   lsGroupBinary = Byte1 & Byte2 & Byte3

                   lsResult = lsResult + lsGroupBinary
           Next
Base64decode = lsResult
End Function

'----------------------------------------------------------------------------------------------
' 문자열 64비트 인코딩
'----------------------------------------------------------------------------------------------
function Base64encode(ByVal asContents)
Const sBASE_64_CHARACTERS = _
           "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" 
        Dim lnPosition
        Dim lsResult
        Dim Char1
        Dim Char2
        Dim Char3
        Dim Char4
        Dim Byte1
        Dim Byte2
        Dim Byte3
        Dim SaveBits1
        Dim SaveBits2
        Dim lsGroupBinary
        Dim lsGroup64

        if Len(asContents) Mod 3 > 0 Then _
        asContents = asContents & String(3 - (Len(asContents) Mod 3), " ")
        lsResult = ""

        For lnPosition = 1 To Len(asContents) Step 3
               lsGroup64 = ""
               lsGroupBinary = Mid(asContents, lnPosition, 3)

               Byte1 = Asc(Mid(lsGroupBinary, 1, 1)): SaveBits1 = Byte1 And 3
               Byte2 = Asc(Mid(lsGroupBinary, 2, 1)): SaveBits2 = Byte2 And 15
               Byte3 = Asc(Mid(lsGroupBinary, 3, 1))

               Char1 = Mid(sBASE_64_CHARACTERS, ((Byte1 And 252) \ 4) + 1, 1)
               Char2 = Mid(sBASE_64_CHARACTERS, (((Byte2 And 240) \ 16) Or _
               (SaveBits1 * 16) And &HFF) + 1, 1)
               Char3 = Mid(sBASE_64_CHARACTERS, (((Byte3 And 192) \ 64) Or _
               (SaveBits2 * 4) And &HFF) + 1, 1)
               Char4 = Mid(sBASE_64_CHARACTERS, (Byte3 And 63) + 1, 1)
               lsGroup64 = Char1 & Char2 & Char3 & Char4

               lsResult = lsResult + lsGroup64
         Next

         Base64encode = lsResult
End Function

'----------------------------------------------------------------------------------------------
' 스크립트 방지
'----------------------------------------------------------------------------------------------
Function TagEncode(ByVal Contans)
	Dim temp
	temp = replace(Contans,"&","&amp;")
	temp = replace(temp,"/","&#47;")
	temp = replace(temp,"""","&quot;")
	temp = replace(temp,"'","&#39;")
	temp = replace(temp,"<","&lt;")
	temp = replace(temp,">","&gt;")
	temp = Replace(temp,VbCrlf,"<br>")
	TagEncode = temp
End Function 

'----------------------------------------------------------------------------------------------
' 스크립트 복구
'----------------------------------------------------------------------------------------------
Function TagDecode(ByVal Contans)
	Dim temp
	temp = replace(Contans,"&amp;","&")
	temp = replace(temp,"&#47;","/")
	temp = replace(temp,"&quot;","""")
	temp = replace(temp,"&#39;","'")
	temp = replace(temp,"&lt;","<")
	temp = replace(temp,"&gt;",">")
	temp = Replace(temp,"<br>",VbCrlf)
	TagDecode = temp
End Function 

'----------------------------------------------------------------------------------------------
' 파일확장자 체크
'----------------------------------------------------------------------------------------------
Function FILE_CHECK_EXT(ByVal filePath)
	Dim fileExt,temp
	fileExt = LCase(Mid(filePath, InStrRev(filePath, ".") + 1))
	'If fileExt = "jpg" Or fileExt = "gif" Or fileExt = "jpeg" Or fileExt = "zip" Or fileExt = "egg" Or fileExt = "doc" Or fileExt = "docx" Or fileExt = "txt" Or fileExt = "alz" Or fileExt = "rar" Or fileExt = "png" Or fileExt = "bmp" Then 
		temp = true
	'Else
	'	temp = false
	'End If
	FILE_CHECK_EXT = temp
End Function 

'----------------------------------------------------------------------------------------------
' 문자 * 가리기
'----------------------------------------------------------------------------------------------
Function StrLenBlind(ByVal str,ByVal length)
	Dim Strlen,StrTemp,StrTemp2
	Strlen = Len(str)
	StrTemp = Mid(str,1,length)
	For i=0 To Strlen - length -1
		StrTemp2 = StrTemp2 & "*"
	Next
	StrTemp = StrTemp & StrTemp2
	StrLenBlind = StrTemp

End Function

Function StrLenBlind2(ByVal str,ByVal length)
	Dim Strlen,StrTemp,StrTemp2
	Strlen = Len(str)
	StrTemp = Mid(str,1,Strlen-length)
	For i=0 To length -1
		StrTemp2 = StrTemp2 & "*"
	Next
	StrTemp = StrTemp & StrTemp2
	StrLenBlind2 = StrTemp

End Function

'----------------------------------------------------------------------------------------------
' 타임스템프
'----------------------------------------------------------------------------------------------
Function Timestamp()
	dim thisTime, unixEpoch
	thisTime = DateSerial(Year(Now), Month(Now), Day(Now)) + TimeSerial(Hour(Now), Minute(Now), Second(Now))
	unixEpoch = "01/01/1970 00:00:00"
	Timestamp = DateDiff("s", unixEpoch, thisTime)
End Function

Function URLDecode(sConvert)
    Dim aSplit
    Dim sOutput
    Dim I
    If IsNull(sConvert) Then
       URLDecode = ""
       Exit Function
    End If

    ' convert all pluses to spaces
    sOutput = REPLACE(sConvert, "+", " ")

    ' next convert %hexdigits to the character
    aSplit = Split(sOutput, "%")

    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If

    URLDecode = sOutput
End Function


 '------------------------HtmlTagRemover -- HTML 테그 제거 함수 -------by Andy---------
 ' 파라미터 설명 : (처리할문자열, 자를길이)
 ' cutlen = 0 일경우 전체 문자열
 '---------------------------------------------------------------------------------------
 function HtmlTagRemover(content, cutlen)
  j=1
  tmpb=2
  length = len(content)
  htmlRemovedContent = content

  Do while length > 0
   k = mid(htmlRemovedContent,j,1)

   if k="<" then
    tmpb = 0
   elseif k = ">" then
    tmpb = 1
   end if

   if tmpb = 0 then
    htmlRemovedContent = left(htmlRemovedContent,j-1) & mid(htmlRemovedContent,j+1)
   elseif tmpb = 1 then
    htmlRemovedContent = left(htmlRemovedContent,j-1) & mid(htmlRemovedContent,j+1)
    tmpb = 2
   else
    j=j+1
   end if
 
   length = length -1
  Loop

  if cutlen <> 0 then
'---------------------------------
' 문자열 한글 영문 숫자 길이변환
'---------------------------------
  dim intPos, chrTemp, strCut, intLength
    '문자열 길이 초기화
    intLength = 0
    intPos = 1

    '문자열 길이만큼 돈다
    do while ( intPos <= Len( htmlRemovedContent ))

       '문자열을 한문자씩 비교한다
        chrTemp = ASC(Mid( htmlRemovedContent, intPos, 1))

        if chrTemp < 0 then '음수값(-)이 나오면 한글임
          strCut = strCut & Mid( htmlRemovedContent, intPos, 1 ) 
          intLength = intLength + 2  '한글일 경우 문자열 길이를 2를 더한다 
        else
          strCut = strCut & Mid( htmlRemovedContent, intPos, 1 )            
          intLength = intLength + 1  '한글이 아닌경우 문자열 길이를 1을 더한다
        end If

        if intLength >= cutlen  then
           exit do
        end if

        intPos = intPos + 1
  
    Loop
   
  
   'htmlRemovedContent = left(htmlRemovedContent, cutlen)&".."
   htmlRemovedContent = strCut
   if intLength >= cutlen  then
		htmlRemovedContent = htmlRemovedContent &".."
	end if
  end if

  HtmlTagRemover = htmlRemovedContent

 end Function


 '** ---------------------------------------------------------------------------
' 함 수 명 : RandomNumber(NumberLength,NumberString)
' 인  자 : 1. NumberLength : 출력자리수 2. NumberString : 임의의 문자로 생성
' 목    적 : 난수생성 리턴
' 플 로 우 :
' 검    수 :
' 생 성 일 : 
' 수    정 :
'** ---------------------------------------------------------------------------
Function RandomNumber(NumberLength,NumberString)

	Const DefaultString = "ABCDEFGHIJKLMNOPQRSTUVXYZ1234567890"
	Dim nCount,RanNum,nNumber,nLength

	Randomize
	If NumberString = "" Then 
		NumberString = DefaultString
	End If

	nLength = Len(NumberString)

	For nCount = 1 To NumberLength
	nNumber = Int((nLength * Rnd)+1)
	RanNum = RanNum & Mid(NumberString,nNumber,1)
	Next

	RandomNumber = RanNum
End Function

Function isValidEmail(myEmail)
	dim isValidE
	dim regEx

	isValidE = True
	set regEx = New RegExp

	regEx.IgnoreCase = False

	regEx.Pattern = "^[a-zA-Z\-\_][\w\.-]*[a-zA-Z0-9\-\_]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
	isValidE = regEx.Test(myEmail)

	isValidEmail = isValidE
End Function

%>