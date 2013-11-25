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
	/// Summary description for forums.
	/// </summary>
	public partial class forums : AdminPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("Administration",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("Forums","");

				BindData();
			}
		}

		protected void DeleteCategory_Load(object sender, System.EventArgs e) 
		{
			((LinkButton)sender).Attributes["onclick"] = "return confirm('Delete this category?')";
		}

		protected void DeleteForum_Load(object sender, System.EventArgs e) 
		{
			((LinkButton)sender).Attributes["onclick"] = "return confirm('Delete this forum?')";
		}

		private void BindData() 
		{
			using(DataSet ds = DB.ds_forumadmin(PageBoardID))
				CategoryList.DataSource = ds.Tables["yaf_Category"];
			DataBind();
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
			this.CategoryList.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.CategoryList_ItemCommand);

		}
		#endregion

		protected void ForumList_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			switch(e.CommandName) 
			{
				case "edit":
					Forum.Redirect(Pages.admin_editforum,"f={0}",e.CommandArgument);
					break;
				case "delete":
					DB.forum_delete(e.CommandArgument);
					BindData();
					break;
			}
		}

		protected void NewForum_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.admin_editforum);
		}

		private void CategoryList_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			switch(e.CommandName) 
			{
				case "edit":
					Forum.Redirect(Pages.admin_editcategory,"c={0}",e.CommandArgument);
					break;
				case "delete":
					if(DB.category_delete(e.CommandArgument))
						BindData();
					else
						AddLoadMessage("You cannot delete this Category as it has at least one forum assigned to it.\nTo move forums click on \"Edit\" and change the category the forum is assigned to.");
					break;
			}
		}

		protected void NewCategory_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.admin_editcategory);
		}
	}
}
