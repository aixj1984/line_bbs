<%@ Control language="c#" Codebehind="editboard.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.editboard" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellSpacing=1 cellPadding=0 width="100%">
<tr>
	<td class=header1 colspan="2">编辑版块</td>
</tr>
<tr>
    <td width="50%" class="postheader"><b>名称:</b><br />板块的名称.</td>
    <td width="50%" class="post"><asp:textbox id=Name runat="server" style="width:100%"></asp:textbox></td>
</tr>
	<tr>
		<td class="postheader"><b>Allow Threaded:</b><br/>Allow threaded view for posts.</td>
		<td class="post"><asp:checkbox runat="server" id="AllowThreaded"/></td>
	</tr>
<asp:placeholder runat="server" id="AdminInfo">
<tr>
	<td class="postheader"><b>用户名:</b><br/>这个模块的管理员名称.</td>
	<td class="post"><asp:textbox runat="server" id="UserName"/></td>
</tr>
<tr>
	<td class="postheader"><b>用户邮箱:</b><br/>模块管理员的Email地址.</td>
	<td class="post"><asp:textbox runat="server" id="UserEmail"/></td>
</tr>
<tr>
	<td class="postheader"><b>管理员密码:</b><br/>输入该模块管理员的密码.</td>
	<td class="post"><asp:textbox runat="server" id="UserPass1" textmode="password"/></td>
</tr>
<tr>
	<td class="postheader"><b>再次输入密码:</b><br/>再次输入管理员密码.</td>
	<td class="post"><asp:textbox runat="server" id="UserPass2" textmode="password"/></td>
</tr>
</asp:placeholder>
<tr>
	<td class=postfooter align=middle colSpan="2">
		<asp:button id=Save runat="server" text="保存" onclick="Save_Click" />
		<asp:Button id=Cancel runat="server" Text="取消" onclick="Cancel_Click" />
	</td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
