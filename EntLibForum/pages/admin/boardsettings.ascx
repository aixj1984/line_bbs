<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Control language="c#" Codebehind="boardsettings.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.boardsettings" %>
<yaf:PageLinks runat="server" id="PageLinks" />
<yaf:adminmenu runat="server" id="Adminmenu1">
	<table class="content" cellSpacing="1" cellPadding="0" width="100%">
		<tr>
			<td class="header1" colSpan="2">��̳����</td>
		</tr>
		<tr>
			<td class="header2" colSpan="2">��̳����ϸ��</td>
		</tr>
		<tr>
			<td class="postheader" width="50%"><b>��̳����:</b><br />
				��̳����.</td>
			<td class="post" width="50%">
				<asp:textbox id="Name" runat="server" Width="300"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>��������ģʽ��Threaded view��:</b><br />
				����������ģʽ�鿴����.</td>
			<td class="post">
				<asp:checkbox id="AllowThreaded" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>��̳:</b><br />
				���ð�������.</td>
			<td class="post">
				<asp:dropdownlist id="Theme" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><b>��ʾ�����Logo :</b><br />
				�������ļ��ж�ȡ����ʾ Logo (��������portal).</td>
			<td class="post">
				<asp:checkbox id="AllowThemedLogo" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>����:</b><br />
				���Ĭ������.</td>
			<td class="post">
				<asp:dropdownlist id="Language" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><b>Ĭ����ʾ������:</b><br />
				�������ڣ�����Ĭ����ʾ������.</td>
			<td class="post">
				<asp:dropdownlist id="ShowTopic" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postfooter" align="center" colSpan="2">
				<asp:Button id="Save" runat="server" text="����" onclick="Save_Click"></asp:Button></td>
		</tr>
	</table>
</yaf:adminmenu>
<yaf:SmartScroller id="SmartScroller1" runat="server" />
