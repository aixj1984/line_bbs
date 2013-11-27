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
	/// Summary description for bannedip.
	/// </summary>
	public partial class bannedip : AdminPage
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) {
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("后台管理",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("Banned IP Addresses","");

				BindData();
			}
		}

		private void BindData() {
			list.DataSource = DB.bannedip_list(PageBoardID,null);
			DataBind();
		}

		private void list_ItemCommand(object sender, RepeaterCommandEventArgs e) {
			if(e.CommandName == "add")
				Forum.Redirect(Pages.admin_bannedip_edit);
			else if(e.CommandName == "edit")
				Forum.Redirect(Pages.admin_bannedip_edit,"i={0}",e.CommandArgument);
			else if(e.CommandName == "delete") {
				DB.bannedip_delete(e.CommandArgument);
				Cache.Remove("bannedip");
				BindData();
				AddLoadMessage("Removed IP address ban.");
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			list.ItemCommand += new RepeaterCommandEventHandler(list_ItemCommand);
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
		}
		#endregion
	}
}
