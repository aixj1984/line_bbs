<%@ Control language="c#" Codebehind="editaccessmask.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.editaccessmask" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellSpacing=1 cellPadding=0 width="100%">
<tr class="header1">
	<td colspan="2">用户权限编辑</td>
</tr>
<tr>
	<td class="postheader" width="50%"><b>名称:</b><br/>权限名称Name of this access mask.</td>
	<td class="post" width="50%"><asp:textbox runat="server" id="Name" cssclass="edit"/></td>
</tr>
<tr>
	<td class="postheader"><b>允许读Read Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="ReadAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>Post Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="PostAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>允许回复Reply Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="ReplyAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>优先访问Priority Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="PriorityAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>允许投票Poll Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="PollAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>投票权限Vote Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="VoteAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>主席权限Moderator Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="ModeratorAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>编辑权限Edit Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="EditAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>删除权限Delete Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="DeleteAccess"/></td>
</tr>
<tr>
	<td class="postheader"><b>更新权限Upload Access:</b></td>
	<td class="post"><asp:checkbox runat="server" id="UploadAccess"/></td>
</tr>

<tr class="postfooter">
    <td align="middle" colspan="2">
		<asp:button id=Save runat="server" text="保存" onclick="Save_Click" />
		<asp:Button id=Cancel runat="server" Text="取消" onclick="Cancel_Click" />
	</td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
