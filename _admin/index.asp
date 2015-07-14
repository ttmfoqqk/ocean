<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <TITLE>관리자</TITLE>
<script language=javascript>
function formsubmit(){
	if(document.adminLoginForm.AdminId.value == ""){
		alert("아이디를 입력하세요!");
		document.adminLoginForm.AdminId.focus();
		return false;
	}
	if(document.adminLoginForm.pass.value == ""){
		alert("패스워드를 입력하세요!");
		document.adminLoginForm.pass.focus();
		return false;
	}
}
</script>

</head>

<body OnLoad="adminLoginForm.AdminId.focus()">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
 <form name="adminLoginForm" method="post" action="login_proc.asp" onsubmit="return formsubmit(this)">
 <input type="hidden" name="GoUrl" value="<%=request("GoUrl")%>">
  <tr>
    <td align="center" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="1" bgcolor="#d2d2d2"></td>
      </tr>
      <tr>
        <td height="309" align="center" bgcolor="#f8f8f8"><table width="612" height="226" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          <tr>
            <td style="border:10px solid #604c4d"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="304"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="33">&nbsp;</td>
                        <td width="212"><img src="img/login/Simg_admin.jpg" width="241" height="148" /></td>
                        <td>&nbsp;</td>
                      </tr>
                  </table></td>
                  <td align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><form action="" method="post" name="id" id="id">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="175" valign="middle"><label></label>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="38"><img src="img/login/Simg_id.jpg" width="38" height="18" /></td>
                                        <td><input name="AdminId" id="AdminId" type="text" style="border:1px solid #d3d3d3" style="width:130px; height:18px;ime-mode:disabled"/></td>
                                      </tr>
                                      <tr>
                                        <td height="5" colspan="2"></td>
                                      </tr>
                                      <tr>
                                        <td><img src="img/login/Simg_pw.jpg" width="38" height="18" /></td>
                                        <td><input name="pass" id="pass" type="password" style="border:1px solid #d3d3d3" style="width:130px; height:18px;"/></td>
                                      </tr>
                                  </table></td>
                                <td align="left" style="padding-left:10px"><input type="image" src="img/login/Sbtn_login.jpg" width="55" height="55" border="0" /></td>
                              </tr>
                            </table>
                        </form></td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="1" bgcolor="#d2d2d2"></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>