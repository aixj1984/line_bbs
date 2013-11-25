<%@ Control language="c#" Codebehind="moderate.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.moderate0" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<table class=content cellspacing=1 cellpadding=0 width=100%>
<tr>
	<td class=header1 colspan=4><%=GetText("MEMBERS")%></td>
</tr>

<tr class="header2">
	<td><%=GetText("USER")%></td>
	<td align="center"><%=GetText("ACCEPTED")%></td>
	<td><%=GetText("ACCESSMASK")%></td>
	<td>操 作</td>
</tr>
<asp:repeater runat="server" id="UserList">
<ItemTemplate>
<tr class="post">
	<td><%# DataBinder.Eval(Container.DataItem,"Name") %></td>
	<td align="center"><%# DataBinder.Eval(Container.DataItem,"Accepted") %></td>
	<td><%# DataBinder.Eval(Container.DataItem,"Access") %></td>
	<td>
		<asp:linkbutton runat="server" text='<%#GetText("EDIT")%>' commandname="edit" commandargument='<%# DataBinder.Eval(Container.DataItem,"UserID") %>'/>
		|
		<asp:linkbutton runat="server" text='<%#GetText("REMOVE")%>' onload="DeleteUser_Load" commandname="remove" commandargument='<%# DataBinder.Eval(Container.DataItem,"UserID") %>'/>
	</td>
</tr>
</ItemTemplate>
</asp:repeater>
<tr class="footer1">
	<td colspan="4"><asp:linkbutton runat="server" id="AddUser" text="Invite User"/></td>
</tr>
</table>

<table class=content cellspacing=1 cellpadding=0 width=100% style="margin-top: 5px;">
<tr>
<td class=header1 colspan=2>设置论坛的图标</td>
</tr>
<tr>
<td>当前论坛的图标</td><td>上传新的图标</td>
</tr>
<tr>
<td>
    <asp:Image ID="imgForumLogo" runat="server" />
    </td><td>请选择本地图像文件：<asp:FileUpload ID="InputFile" runat="server" />
        <br />
        <br />
        图片的显示大小为：155*80，因此建议您上传相同大小的图像文件。<br />
        另外，限制图片大小为：10K以内。文件后缀必须为：jpg / gif / png 等等。<br />
        <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>
    </td>
</tr>
<tr>
<td>
    <asp:Button ID="btnClearForumLogo" runat="server" Text="清除论坛图标" 
        onclick="btnClearForumLogo_Click" />
    </td><td>
    <asp:Button ID="btnUploadForumLogo" runat="server" Text="上传论坛图标" 
            onclick="btnUploadForumLogo_Click" />
    </td>
</tr>
</table>
<br/>
备注：精华等级允许为：1，2，3个级别，如果设置为0，表示取消精华设置。
<table class=content cellspacing=1 cellpadding=0 width=100%>
<tr>
	<td class=header1 colspan=7>版主审核</td>
</tr>
<tr>
	<td class=header2 width="1%">&nbsp;</td>
	<td class=header2 align=left>话题</td>
	<td class=header2 align=left width="10%">话题发起人%></td>
	<td class=header2 align="center" width="7%">回复</td>
	<td class=header2 align="center" width="7%">浏览</td>
	<td class=header2 align="center" width="15%">最后发表</td>
	<td class=header2 align="center">操作</td>
</tr>

<asp:repeater id=topiclist runat=server>
<itemtemplate>
	<yaf:TopicLine runat="server" DataRow="<%# Container.DataItem %>">
		<td class="postheader" align="left" nowrap>
			<asp:linkbutton runat=server onload="Delete_Load" commandargument='<%# DataBinder.Eval(Container.DataItem, "TopicID") %>' commandname='delete'>删除话题</asp:linkbutton>
			| <asp:linkbutton ID="btnSetDigest" runat=server commandargument='<%# DataBinder.Eval(Container.DataItem, "TopicID")%>' CommandName='digest'>设置精华</asp:linkbutton>：<asp:TextBox ID="txtDigestLevel" runat="server" Width="20" Text='<%# DataBinder.Eval(Container.DataItem, "DigestLevel") %>'></asp:TextBox>&nbsp;
            | <asp:linkbutton ID="btnRecommend" runat=server commandargument='<%# DataBinder.Eval(Container.DataItem, "TopicID")%>' CommandName='recommend' Text='<%# GetRecommendOpt(Eval("ApproveStatus")) %>'></asp:linkbutton>
		</td>
	</yaf:TopicLine>
</itemtemplate>
</asp:repeater>

<tr>
	<td class=footer1 colspan=7>&nbsp;</td>
</tr>
</table>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
