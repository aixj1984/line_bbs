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
	public partial class accessmasks : AdminPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("后台管理",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("权限设置","");
				BindData();
			}
		}

		protected void Delete_Load(object sender, System.EventArgs e) 
		{
			((LinkButton)sender).Attributes["onclick"] = "return confirm('确认删除这个吗?')";
		}

		private void BindData() 
		{
			List.DataSource = DB.accessmask_list(PageBoardID,null);
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
			this.List.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.List_ItemCommand);

		}
		#endregion

		private void List_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			switch(e.CommandName) 
			{
				case "edit":
					Forum.Redirect(Pages.admin_editaccessmask,"i={0}",e.CommandArgument);
					break;
				case "delete":
					if(DB.accessmask_delete(e.CommandArgument))
						BindData();
					else
						AddLoadMessage("你不能删除一个在用的用户组。");
					break;
			}
		}

		protected void New_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.admin_editaccessmask);
		}

		protected string BitSet(object _o,int bitmask) 
		{
			int i = (int)_o;
			return (i & bitmask)!=0?"是":"否";
		}
	}
}
