using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Drawing;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for moderate.
	/// </summary>
	public partial class moderate0 : ForumPage
	{

		public moderate0()
			: base( "MODERATE" )
		{
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
			if ( !ForumModeratorAccess )
				Data.AccessDenied();

			if ( !IsPostBack )
			{
				AddUser.Text = GetText( "INVITE" );

				if ( ForumControl.LockedForum == 0 )
				{
					PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
					PageLinks.AddLink( PageCategoryName, Forum.GetLink( Pages.forum, "c={0}", PageCategoryID ) );
				}
				PageLinks.AddForumLinks( PageForumID );
				PageLinks.AddLink( GetText( "TITLE" ), "" );
			}
			BindData();
		}

		private void AddUser_Click( object sender, System.EventArgs e )
		{
			Forum.Redirect( Pages.mod_forumuser, "f={0}", PageForumID );
		}

		protected void Delete_Load( object sender, System.EventArgs e )
		{
			( ( LinkButton ) sender ).Attributes ["onclick"] = String.Format( "return confirm('{0}')", GetText( "confirm_delete" ) );
		}

		protected void DeleteUser_Load( object sender, System.EventArgs e )
		{
			( ( LinkButton ) sender ).Attributes ["onclick"] = String.Format( "return confirm('{0}')", "Remove this user from this forum?" );
		}

		private void BindData()
		{
			topiclist.DataSource = DB.topic_list( PageForumID, -1, null, 0, 999999 );
			UserList.DataSource = DB.userforum_list( null, PageForumID );

            DataTable dt = DB.forum_getspecifiedforum(PageForumID);
            if (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["ForumIcon"].ToString().Trim().Length > 0)
            {
                string strPath = "~/images/forumicons/";
                imgForumLogo.ImageUrl = strPath + dt.Rows[0]["ForumIcon"].ToString().Trim();
                imgForumLogo.Visible = true;
            }
            else
            {
                imgForumLogo.Visible = false;
            }

			DataBind();
		}

		private void topiclist_ItemCommand( object sender, RepeaterCommandEventArgs e )
		{
			if ( e.CommandName == "delete" )
			{
				DB.topic_delete( e.CommandArgument );
				AddLoadMessage( GetText( "deleted" ) );
				BindData();
			}
            else if (e.CommandName == "digest")
            {
                TextBox txtDigestLevel = (TextBox)e.Item.FindControl("txtDigestLevel");

                string strDigestLevel = txtDigestLevel.Text.Trim();
                int digestLevel;

                if (UtilityValidation.IsInteger(strDigestLevel))
                {
                    digestLevel = Convert.ToInt32(strDigestLevel);
                    if (digestLevel > 3)
                        digestLevel = 3;
                    else if (digestLevel < 0)
                        digestLevel = 0;
                }
                else
                {
                    digestLevel = 0;
                }
                
                DB.topic_setdigest(e.CommandArgument, digestLevel);
                BindData();
            }
            else if (e.CommandName == "recommend")
            {
                LinkButton btnRecommend = (LinkButton)e.Item.FindControl("btnRecommend");
                int isRecommend;

                if (btnRecommend != null && btnRecommend.Text.Trim() == "推荐")
                { 
                    isRecommend = 1;
                }
                else
                {
                    isRecommend = 0;
                }

                DB.topic_setrecommend(e.CommandArgument, isRecommend);

                BindData();
            }

		}

		private void UserList_ItemCommand( object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e )
		{
			switch ( e.CommandName )
			{
				case "edit":
					Forum.Redirect( Pages.mod_forumuser, "f={0}&u={1}", PageForumID, e.CommandArgument );
					break;
				case "remove":
					DB.userforum_delete( e.CommandArgument, PageForumID );
					BindData();
					break;
			}
		}

        protected string GetRecommendOpt(object approveStatus)
        {
            string strResult = string.Empty;

            if (approveStatus == System.DBNull.Value || Convert.ToInt32(approveStatus) == 0)
            {
                strResult = "推荐";
            }
            else
            {
                strResult = "取消推荐";
            }

            return strResult;
        }

		#region Web Form Designer generated code
		override protected void OnInit( EventArgs e )
		{
			topiclist.ItemCommand += new RepeaterCommandEventHandler( topiclist_ItemCommand );
			UserList.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler( this.UserList_ItemCommand );
			AddUser.Click += new EventHandler( AddUser_Click );
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit( e );
		}

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}
		#endregion

        protected void btnClearForumLogo_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = DB.forum_getspecifiedforum(PageForumID);
                if (dt != null && dt.Rows.Count > 0)
                {
                    DB.forum_updatelogo(PageForumID, string.Empty);
                }
                else
                {
                    lblMessage.Text = "该论坛板块没有设置图标。";
                    lblMessage.ForeColor = Color.Red;
                }

                imgForumLogo.Visible = false;

            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }

        protected void btnUploadForumLogo_Click(object sender, EventArgs e)
        {
            string uploadName = InputFile.FileName.Trim();//获取待上传图片的完整路径，包括文件名 
            string pictureName = "";//上传后的图片名，以当前时间为文件名，确保文件名没有重复 
            if (uploadName.Trim() != "") 
            { 
                int idx = uploadName.LastIndexOf("."); 
                string suffix = uploadName.Substring(idx).Trim().ToLower();//获得上传的图片的后缀名 
                if (suffix != ".gif" && suffix != ".jpg" && suffix != ".png")
                {
                    lblMessage.Text = "请必须上传符合条件的图片文件。";
                    lblMessage.ForeColor = Color.Red;

                    return;
                }
                string filename = uploadName.Substring(0,idx);
                pictureName = filename + "_" + DateTime.Now.Ticks.ToString() + suffix; 
            } 
            try 
            { 
                if (pictureName != "") 
                {
                    string path = Server.MapPath("~/images/forumicons/"); 

                    InputFile.PostedFile.SaveAs(path + pictureName);

                    DB.forum_updatelogo(PageForumID, pictureName);

                    lblMessage.Text = "上传成功。";
                    lblMessage.ForeColor = Color.Blue;

                    imgForumLogo.ImageUrl = "~/images/forumicons/" + pictureName;
                    imgForumLogo.Visible = true;
                } 
            } 
            catch (Exception ex) 
            { 
                lblMessage.Text = ex.Message;
                lblMessage.ForeColor = Color.Red;
            } 
        }
	}
}
