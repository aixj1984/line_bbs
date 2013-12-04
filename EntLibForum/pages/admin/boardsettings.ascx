<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Control language="c#" Codebehind="boardsettings.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.boardsettings" %>
<yaf:PageLinks runat="server" id="PageLinks" />
<yaf:adminmenu runat="server" id="Adminmenu1">
	<table class="content" cellSpacing="1" cellPadding="0" width="100%">
		<tr>
			<td class="header1" colSpan="2">论坛设置</td>
		</tr>
		<tr>
			<td class="header2" colSpan="2">论坛配置细节</td>
		</tr>
		<tr>
			<td class="postheader" width="50%"><b>论坛名称:</b><br />
				论坛名称.</td>
			<td class="post" width="50%">
				<asp:textbox id="Name" runat="server" Width="300"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>允许线索模式（Threaded view）:</b><br />
				允许以线索模式查看帖子.</td>
			<td class="post">
				<asp:checkbox id="AllowThreaded" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>论坛:</b><br />
				设置版块的主题.</td>
			<td class="post">
				<asp:dropdownlist id="Theme" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><b>显示主题的Logo :</b><br />
				从主题文件中读取并显示 Logo (不适用于portal).</td>
			<td class="post">
				<asp:checkbox id="AllowThemedLogo" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>语言:</b><br />
				版块默认语言.</td>
			<td class="post">
				<asp:dropdownlist id="Language" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><b>默认显示的主题:</b><br />
				根据日期，设置默认显示的主题.</td>
			<td class="post">
				<asp:dropdownlist id="ShowTopic" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postfooter" align="center" colSpan="2">
				<asp:Button id="Save" runat="server" text="保存" onclick="Save_Click"></asp:Button></td>
		</tr>
	</table>
</yaf:adminmenu>
<yaf:SmartScroller id="SmartScroller1" runat="server" />
