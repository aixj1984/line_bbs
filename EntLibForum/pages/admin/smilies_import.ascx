<%@ Control language="c#" Codebehind="smilies_import.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.smilies_import" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content width=100% cellspacing=1 cellpadding=0>
<tr>
	<td class=header1 colspan="2">导入微笑图表包Import Smiley Pack</td>
</tr>
<tr>
	<td class=postheader width=50%><b>选择一个.pak文件Choose .pak file:</b><br/>你必须解压这个微笑包，并且上传所有文件到微笑包所在的目录(images/emoticons) You'll have to unpack the smiley package and upload all files to your smiley directory (images/emoticons).</td>
	<td class=post width=50%><asp:dropdownlist id=File runat="server"/></td>
</tr>
<tr>
	<td class=postheader width=50%><b>删除已经存储的微笑包Delete existing smilies:</b><br/>如果勾选，则会删除已经存在的微笑包Will delete all existing smilies if you check this.</td>
	<td class=post width=50%><asp:checkbox id=DeleteExisting runat="server"/></td>
</tr>
<tr>
	<td class=footer1 colspan="2" align=center>
		<asp:button id=import runat=server text="Import"/>
		<asp:button id=cancel runat=server Text="取消"/>
	</td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
