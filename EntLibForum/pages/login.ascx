<%@ Control language="c#" Codebehind="login.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.login" %>
<%@ Register Assembly="WebValidates" Namespace="WebValidates" TagPrefix="cc1" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<div align="center">
<table align="center" width="100%" cellspacing="1" cellpadding="0" class="content" id="LoginView" runat="server">
<tr>
	<td class="header1" colspan="2"><%= GetText("title") %></td>
</tr>
<tr>
	<td class="postheader" width="50%"><%= GetText("username") %></td>
	<td class="post" width="50%"><asp:TextBox id="UserName" runat="server"/></td>
</tr>
<tr>
	<td class=postheader><%= GetText("password") %></td>
	<td class=post><asp:TextBox id=Password runat="server" TextMode="Password"/></td>
</tr>
<tr>
	<td class=postheader>验证码 (不区分大小写):</td>
	<td class=post><asp:TextBox ID="snvTxt1" runat="server"></asp:TextBox>
	<cc1:SerialNumber ID="SerialNumber1" runat="server">
        </cc1:SerialNumber>&nbsp;&nbsp;</td>
</tr>
<tr>
	<td class=postheader><%= GetText("auto") %></td>
	<td class=post><asp:CheckBox id="AutoLogin" runat="server" Checked="true"/></td>
</tr>
<tr>
	<td class=postfooter colspan="2" align=middle>
		<asp:Button id=ForumLogin cssclass="pbutton" runat="server" onclick="ForumLogin_Click" />
		<asp:button id=LostPassword cssclass="pbutton" runat="server"/>
	</td>
</tr>
</table>
</div>

<div align="center">
<table class=content width="100%" cellspacing=1 cellpadding=0 id=RecoverView runat=server visible=false>
<tr>
	<td class=header1 colspan="2"><%= GetText("recover") %></td>
</tr>
<tr>
	<td class=postheader width=50%><%= GetText("username") %></td>
	<td class=post width=50%><asp:textbox id=LostUserName runat="server"/></td>
</tr>
<tr>
	<td class=postheader><%= GetText("email") %></td>
	<td class=post><asp:textbox id=LostEmail runat="server"/></td>
</tr>
<tr>
	<td class=postheader>验证码 (不区分大小写):</td>
	<td class=post><asp:TextBox ID="snvTxt2" runat="server"></asp:TextBox>
	<cc1:SerialNumber ID="SerialNumber2" runat="server">
        </cc1:SerialNumber>&nbsp;&nbsp;</td>
</tr>
<tr>
	<td class=footer1 colspan="2" align=middle><asp:button id="Recover" runat="server"/></td>
</tr>
</table>
</div>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
