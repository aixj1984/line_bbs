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
	public partial class replacewords : AdminPage
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("Administration",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("Replace Words","");

				BindData();
			}
		}

		private void BindData() 
		{
			list.DataSource = DB.replace_words_list();
			DataBind();
		}

		private void list_ItemCommand(object sender, RepeaterCommandEventArgs e) 
		{
			if(e.CommandName == "add")
				Forum.Redirect(Pages.admin_replacewords_edit);
			else if(e.CommandName == "edit")
				Forum.Redirect(Pages.admin_replacewords_edit,"i={0}",e.CommandArgument);
			else if(e.CommandName == "delete") 
			{
				DB.replace_words_delete(e.CommandArgument);
				Cache.Remove("replacewords");
				BindData();
				AddLoadMessage("Removed word filter.");
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
