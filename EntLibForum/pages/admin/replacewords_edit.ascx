<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Control language="c#" Codebehind="replacewords_edit.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.replacewords_edit" %>
<yaf:PageLinks runat="server" id="PageLinks" />
<yaf:adminmenu runat="server" id="Adminmenu1">
	<table class="content" cellSpacing="1" cellPadding="0" width="100%">
		<tr>
			<td class="header1" colSpan="2">增加或编辑替换单词Add/Edit Word Replace</td>
		</tr>
		<tr>
			<td class="postheader" width="50%"><B>禁止的单词Bad Word</B></td>
			<td class="post" width="50%">
				<asp:textbox id="badword" runat="server"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader" width="50%"><B>替换成的单词Good Word</B></td>
			<td class="post" width="50%">
				<asp:textbox id="goodword" runat="server"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postfooter" align="center" colSpan="2">
				<asp:button id="save" runat="server" text="保存"></asp:button>
				<asp:button id="cancel" runat="server" Text="取消"></asp:button></td>
		</tr>
	</table>
</yaf:adminmenu>
<yaf:SmartScroller id="SmartScroller1" runat = "server" />
