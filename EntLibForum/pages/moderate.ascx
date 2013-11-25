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
	<td>�� ��</td>
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
<td class=header1 colspan=2>������̳��ͼ��</td>
</tr>
<tr>
<td>��ǰ��̳��ͼ��</td><td>�ϴ��µ�ͼ��</td>
</tr>
<tr>
<td>
    <asp:Image ID="imgForumLogo" runat="server" />
    </td><td>��ѡ�񱾵�ͼ���ļ���<asp:FileUpload ID="InputFile" runat="server" />
        <br />
        <br />
        ͼƬ����ʾ��СΪ��155*80����˽������ϴ���ͬ��С��ͼ���ļ���<br />
        ���⣬����ͼƬ��СΪ��10K���ڡ��ļ���׺����Ϊ��jpg / gif / png �ȵȡ�<br />
        <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>
    </td>
</tr>
<tr>
<td>
    <asp:Button ID="btnClearForumLogo" runat="server" Text="�����̳ͼ��" 
        onclick="btnClearForumLogo_Click" />
    </td><td>
    <asp:Button ID="btnUploadForumLogo" runat="server" Text="�ϴ���̳ͼ��" 
            onclick="btnUploadForumLogo_Click" />
    </td>
</tr>
</table>
<br/>
��ע�������ȼ�����Ϊ��1��2��3�������������Ϊ0����ʾȡ���������á�
<table class=content cellspacing=1 cellpadding=0 width=100%>
<tr>
	<td class=header1 colspan=7>�������</td>
</tr>
<tr>
	<td class=header2 width="1%">&nbsp;</td>
	<td class=header2 align=left>����</td>
	<td class=header2 align=left width="10%">���ⷢ����%></td>
	<td class=header2 align="center" width="7%">�ظ�</td>
	<td class=header2 align="center" width="7%">���</td>
	<td class=header2 align="center" width="15%">��󷢱�</td>
	<td class=header2 align="center">����</td>
</tr>

<asp:repeater id=topiclist runat=server>
<itemtemplate>
	<yaf:TopicLine runat="server" DataRow="<%# Container.DataItem %>">
		<td class="postheader" align="left" nowrap>
			<asp:linkbutton runat=server onload="Delete_Load" commandargument='<%# DataBinder.Eval(Container.DataItem, "TopicID") %>' commandname='delete'>ɾ������</asp:linkbutton>
			| <asp:linkbutton ID="btnSetDigest" runat=server commandargument='<%# DataBinder.Eval(Container.DataItem, "TopicID")%>' CommandName='digest'>���þ���</asp:linkbutton>��<asp:TextBox ID="txtDigestLevel" runat="server" Width="20" Text='<%# DataBinder.Eval(Container.DataItem, "DigestLevel") %>'></asp:TextBox>&nbsp;
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
