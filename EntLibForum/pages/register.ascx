<%@ Control language="c#" Codebehind="register.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.register" %>
<%@ Register Assembly="WebValidates" Namespace="WebValidates" TagPrefix="cc1" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<table class="content" cellspacing=1 cellpadding=0 width="100%">
	<tr>
		<td class=header1 colspan="2"><%# GetText("title") %></td>
	</tr>
	<tr>
		<td class=header2 colspan="2" align="middle"><%# GetText("details") %></td>
	</tr>
	<tr>
		<td width="50%" class=postheader><%# GetText("username") %>（用户名长度必须大于或等于3位）:</td>
		<td class=post>
			<asp:TextBox id=UserName runat="server"/>
			<asp:RequiredFieldValidator runat="server" ErrorMessage='<%# GetText("need_username") %>' ControlToValidate="UserName" EnableClientScript="False" ID="reqUserName"/>
		</td>
	</tr>
	<tr>
		<td class=postheader><%# GetText("password") %>（密码长度必须大于或等于3位）:</td>
		<td class=post>
			<asp:TextBox id=Password runat="server" TextMode="Password"/>
			<asp:RequiredFieldValidator runat="server" ErrorMessage='<%# GetText("need_password") %>' ControlToValidate="Password" EnableClientScript="False" ID="reqPassword"/>
		</td>
	</tr>
	<tr>
		<td class=postheader><%# GetText("retype_password") %>:</td>
		<td class=post>
			<asp:TextBox id=Password2 runat="server" TextMode="Password"/>
			<asp:CompareValidator runat="server" ErrorMessage='<%# GetText("need_match") %>' ControlToValidate="Password2" ControlToCompare="Password" EnableClientScript="False" ID="cmpPassword" />
		</td>
	</tr>
	<tr>
		<td class=postheader><%# GetText("email") %>:</td>
		<td class=post><asp:TextBox id=Email runat="server" Width="280px"/></td>
	</tr>
	<tr>
		<td class=header2 colspan="2" align="middle"><%# GetText("profile") %></td>
	</tr>
	<tr>
		<td class=postheader><%# GetText("location") %>:</td>
		<td class=post><asp:TextBox id=Location runat="server" Width="280px"/></td>
	</tr>
	<tr>
		<td class=postheader><%# GetText("homepage") %>:</td>
		<td class=post><asp:TextBox id=HomePage runat="server" Width="280px"/></td>
	</tr>
	<tr>
		<td class="header2" colspan="2" align="middle"><%# GetText("preferences") %></td>
	</tr>
	<tr>
		<td class=postheader><%# GetText("timezone") %>:</td>
		<td class=post><asp:DropDownList id=TimeZones runat="server" DataTextField="Name" DataValueField="Value"/></td>
	</tr>
	<tr>
	<td class=postheader>验证码 (不区分大小写):</td>
	<td class=post><cc1:SerialNumber ID="SerialNumber1" runat="server">
        </cc1:SerialNumber>&nbsp;&nbsp;<asp:TextBox ID="snvTxt1" runat="server"></asp:TextBox></td>
</tr>
	<tr>
		<td align="middle" colspan="2" class=footer1>
			<asp:Button id=ForumRegister cssclass="pbutton" runat="server" onclick="ForumRegister_Click" />
			<asp:button id=cancel cssclass="pbutton" runat="server"/>
		</td>
	</tr>
</table>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
