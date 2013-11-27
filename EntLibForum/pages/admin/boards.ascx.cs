using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages.admin
{
	/// <summary>
	/// Summary description for members.
	/// </summary>
	public partial class boards : AdminPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsHostAdmin)
				Data.AccessDenied();

			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("后台管理",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("板块设置","");

				BindData();
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.List.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.List_ItemCommand);
			this.New.Click += new EventHandler(New_Click);
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			base.OnInit(e);
		}
		#endregion
	
		protected void Delete_Load(object sender, System.EventArgs e) 
		{
			((LinkButton)sender).Attributes["onclick"] = "return confirm('Delete this board?')";
		}

		private void BindData() 
		{
			List.DataSource = DB.board_list(null);
			DataBind();
		}

		private void New_Click(object sender,EventArgs e) 
		{
			Forum.Redirect(Pages.admin_editboard);
		}

		private void List_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e) {
			switch(e.CommandName) {
				case "edit":
					Forum.Redirect(Pages.admin_editboard,"b={0}",e.CommandArgument);
					break;
				case "delete":
					DB.board_delete(e.CommandArgument);
					BindData();
					break;
			}
		}
	}
}
