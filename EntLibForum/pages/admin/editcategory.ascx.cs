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
	/// Summary description for editcategory.
	/// </summary>
	public partial class editcategory : AdminPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("后台管理",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("Forums","");

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

		}
		#endregion

		protected void Cancel_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.admin_forums);
		}

		private void BindData() 
		{
			if(Request.QueryString["c"] != null) 
			{
				using(DataTable dt = DB.category_list(PageBoardID,Request.QueryString["c"]))
				{
					DataRow row = dt.Rows[0];
					Name.Text = (string)row["Name"];
					SortOrder.Text = row["SortOrder"].ToString();
					CategoryNameTitle.Text = Name.Text;
				}
			}
		}

		protected void Save_Click(object sender, System.EventArgs e)
		{
			int CategoryID = 0;
			if(Request.QueryString["c"] != null) CategoryID = int.Parse(Request.QueryString["c"]);

			DB.category_save(PageBoardID,CategoryID,Name.Text,SortOrder.Text);
			Forum.Redirect(Pages.admin_forums);
		}
	}
}
