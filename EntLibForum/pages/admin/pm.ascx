<%@ Control language="c#" Codebehind="pm.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.pm" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellspacing=1 cellpadding=0 width=100%>
<tr>
	<td class=header1 colspan="2">�ҵ���Ϣ</td>
</tr>
<tr>
	<td class="postheader" width="50%">��Ϣ����:</td>
	<td class="post" width="50%"><asp:label runat="server" id="Count"/></td>
</td>
<tr>
	<td class="postheader" width="50%">ɾ���Ѷ��ġ�����ָ����������Ϣ:</td>
	<td class="post" width="50%"><asp:textbox runat="server" id="Days1"/> ��</td>
</td>
<tr>
	<td class="postheader" width="50%">ɾ��δ���ġ�����ָ����������Ϣ:</td>
	<td class="post" width="50%"><asp:textbox runat="server" id="Days2"/> ��</td>
</td>

<tr>
	<td class=footer1 colspan="2" align=center>
		<asp:button id=commit runat=server text="ɾ����Ϣ"/>
	</td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

