<%@ Page language="c#" Codebehind="error.aspx.cs" AutoEventWireup="True" Inherits="yaf.error" %>

<table class=content width=100% cellspacing=1 cellpadding=0>
<tr>
	<td class=header1>Error</td>
</tr>
<tr>
	<td class=post id=errormsg runat=server>
        <asp:label id="lblMessage" runat="server"></asp:label>
    </td>
</tr>
</table>