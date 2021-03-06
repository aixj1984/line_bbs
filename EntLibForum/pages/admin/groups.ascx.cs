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
	/// Summary description for groups.
	/// </summary>
	public partial class groups : AdminPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("后台管理",Forum.GetLink(Pages.admin_admin));
                PageLinks.AddLink("组(角色)", "");

				BindData();
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
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
			this.GroupList.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.GroupList_ItemCommand);

		}
		#endregion

		protected void Delete_Load(object sender, System.EventArgs e) 
		{
			((LinkButton)sender).Attributes["onclick"] = "return confirm('Delete this group?')";
		}

		private void BindData() 
		{
			GroupList.DataSource = DB.group_list(PageBoardID,null);
			DataBind();
		}

		private void GroupList_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			switch(e.CommandName) 
			{
				case "edit":
					Forum.Redirect(Pages.admin_editgroup,"i={0}",e.CommandArgument);
					break;
				case "delete":
					DB.group_delete(e.CommandArgument);
					BindData();
					break;
			}
		}

		protected void NewGroup_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.admin_editgroup);
		}

		protected string BitSet(object _o,int bitmask) 
		{
			int i = (int)_o;
			return (i & bitmask)!=0?"是":"否";
		}
	}
}
