using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace yaf.controls
{
    public partial class EditUsersGroups : BaseUserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            UserGroups.DataSource = DB.group_member(ForumPage.PageBoardID, Request.QueryString["u"]);
            DataBind();
        }
        
        protected bool IsMember(object o)
        {
            return long.Parse(o.ToString()) > 0;
        }

        protected void Cancel_Click(object sender, System.EventArgs e)
        {
            Forum.Redirect(Pages.admin_users);
        }

        protected void Save_Click(object sender, System.EventArgs e)
        {
            for (int i = 0; i < UserGroups.Items.Count; i++)
            {
                RepeaterItem item = UserGroups.Items[i];
                int GroupID = int.Parse(((Label)item.FindControl("GroupID")).Text);
                DB.usergroup_save(Request.QueryString["u"], GroupID, ((CheckBox)item.FindControl("GroupMember")).Checked);
            }

            Forum.Redirect(Pages.admin_users);
        }

    }
}