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
	/// Summary description for editgroup.
	/// </summary>
	public partial class editnntpforum : AdminPage
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("后台管理",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("NNTP Forums","");
				
				BindData();
				if(Request.QueryString["s"] != null) 
				{
					using(DataTable dt = DB.nntpforum_list(PageBoardID,null,Request.QueryString["s"],DBNull.Value))
					{
						DataRow row = dt.Rows[0];
						NntpServerID.Items.FindByValue(row["NntpServerID"].ToString()).Selected = true;
						GroupName.Text = row["GroupName"].ToString();
						ForumID.Items.FindByValue(row["ForumID"].ToString()).Selected = true;
						Active.Checked = (bool)row["Active"];
					}
				}
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

		private void BindData()
		{
			NntpServerID.DataSource = DB.nntpserver_list(PageBoardID,null);
			NntpServerID.DataValueField = "NntpServerID";
			NntpServerID.DataTextField = "Name";
			ForumID.DataSource = DB.forum_listall_sorted(PageBoardID,PageUserID);
			ForumID.DataValueField = "ForumID";
			ForumID.DataTextField = "Title";
			DataBind();
		}

		protected void Cancel_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.admin_nntpforums);
		}

		protected void Save_Click(object sender, System.EventArgs e)
		{
			object nntpForumID = null;
			if(Request.QueryString["s"]!=null) nntpForumID = Request.QueryString["s"];
			DB.nntpforum_save(nntpForumID,NntpServerID.SelectedValue,GroupName.Text,ForumID.SelectedValue,Active.Checked);
			Forum.Redirect(Pages.admin_nntpforums);
		}
	}
}
