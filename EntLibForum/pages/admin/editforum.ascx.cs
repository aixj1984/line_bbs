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
	/// Administrative Page for the editting of forum properties.
	/// </summary>
	public partial class editforum : AdminPage
	{

		protected void Page_Load( object sender, System.EventArgs e )
		{
			if ( !IsPostBack )
			{
				PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
				PageLinks.AddLink( "后台管理", Forum.GetLink( Pages.admin_admin ) );
				PageLinks.AddLink( "论坛", "" );

				BindData();
				if ( Request.QueryString ["f"] != null )
				{
					using ( DataTable dt = DB.forum_list( PageBoardID, Request.QueryString ["f"] ) )
					{
						DataRow row = dt.Rows [0];
						Name.Text = ( string ) row ["Name"];
						Description.Text = ( string ) row ["Description"];
						SortOrder.Text = row ["SortOrder"].ToString();
						HideNoAccess.Checked = ( ( int ) row ["Flags"] & ( int ) ForumFlags.Hidden ) == ( int ) ForumFlags.Hidden;
						Locked.Checked = ( ( int ) row ["Flags"] & ( int ) ForumFlags.Locked ) == ( int ) ForumFlags.Locked;
						IsTest.Checked = ( ( int ) row ["Flags"] & ( int ) ForumFlags.IsTest ) == ( int ) ForumFlags.IsTest;
						ForumNameTitle.Text = Name.Text;
						Moderated.Checked = ( ( int ) row ["Flags"] & ( int ) ForumFlags.Moderated ) == ( int ) ForumFlags.Moderated;

						CategoryList.SelectedValue = row ["CategoryID"].ToString();
						if ( !row.IsNull( "ParentID" ) )
							ParentList.SelectedValue = row ["ParentID"].ToString();
						if ( !row.IsNull( "ThemeURL" ) )
							ThemeList.SelectedValue = row ["ThemeURL"].ToString();

						remoteurl.Text = row ["RemoteURL"].ToString();
                        //add  by aixj for icon 
                        icon_path.Text = row["ForumIcon"].ToString(); 
                        //add end
					}
					NewGroupRow.Visible = false;
				}
			}
		}

		private void BindData()
		{
			int ForumID = 0;
			CategoryList.DataSource = DB.category_list( PageBoardID, null );
			CategoryList.DataBind();

			if ( Request.QueryString ["f"] != null )
			{
				ForumID = Convert.ToInt32( Request.QueryString ["f"] );
				AccessList.DataSource = DB.forumaccess_list( ForumID );
				AccessList.DataBind();
			}

			// Load forum's combo
			ParentList.DataSource = DB.forum_listall_fromCat( PageBoardID, CategoryList.SelectedValue );
			ParentList.DataValueField = "ForumID";
			ParentList.DataTextField = "Title";
			ParentList.DataBind();

			// Load forum's themes
			ListItem listheader = new ListItem();
			listheader.Text = "Choose a theme";
			listheader.Value = "";

			AccessMaskID.DataBind();

			ThemeList.DataSource = Data.Themes();
			ThemeList.DataTextField = "Theme";
			ThemeList.DataValueField = "FileName";
			ThemeList.DataBind();
			ThemeList.Items.Insert( 0, listheader );
		}

		public void Category_Change( object sender, System.EventArgs e )
		{
			ParentList.DataSource = DB.forum_listall_fromCat( PageBoardID, CategoryList.SelectedValue );
			ParentList.DataValueField = "ForumID";
			ParentList.DataTextField = "Title";
			ParentList.DataBind();
		}

		override protected void OnInit( EventArgs e )
		{
			this.CategoryList.AutoPostBack = true;
			this.Save.Click += new System.EventHandler( this.Save_Click );
			this.Cancel.Click += new System.EventHandler( this.Cancel_Click );
			base.OnInit( e );
		}

		private void Save_Click( object sender, System.EventArgs e )
		{
			if ( CategoryList.SelectedValue.Trim().Length == 0 )
			{
				AddLoadMessage( "必须选择一个目录You must select a category for the forum." );
				return;
			}
			if ( Name.Text.Trim().Length == 0 )
			{
				AddLoadMessage( "比如输入论坛的名称You must enter a name for the forum." );
				return;
			}
			if ( Description.Text.Trim().Length == 0 )
			{
				AddLoadMessage( "必须输入论坛的描述You must enter a description for the forum." );
				return;
			}
			if ( SortOrder.Text.Trim().Length == 0 )
			{
				AddLoadMessage( "必须输入一个序号。You must enter a value for sort order." );
				return;
			}

			// Forum
			long ForumID = 0;
			if ( Request.QueryString ["f"] != null )
			{
				ForumID = long.Parse( Request.QueryString ["f"] );
			}
			else if ( AccessMaskID.SelectedValue.Length == 0 )
			{
				AddLoadMessage( "You must select an initial access mask for the forum." );
				return;
			}

			object parentID = null;
			if ( ParentList.SelectedValue.Length > 0 )
				parentID = ParentList.SelectedValue;

			object themeURL = null;
			if ( ThemeList.SelectedValue.Length > 0 )
				themeURL = ThemeList.SelectedValue;

            ForumID = DB.forum_save(ForumID, CategoryList.SelectedValue, parentID, Name.Text, Description.Text, SortOrder.Text, Locked.Checked, HideNoAccess.Checked, IsTest.Checked, Moderated.Checked, AccessMaskID.SelectedValue, IsNull(remoteurl.Text), themeURL, IsNull(icon_path.Text), false);

			// Access
			if ( Request.QueryString ["f"] != null )
			{
				for ( int i = 0; i < AccessList.Items.Count; i++ )
				{
					RepeaterItem item = AccessList.Items [i];
					int GroupID = int.Parse( ( ( Label ) item.FindControl( "GroupID" ) ).Text );
					DB.forumaccess_save( ForumID, GroupID, ( ( DropDownList ) item.FindControl( "AccessmaskID" ) ).SelectedValue );
				}
				Forum.Redirect( Pages.admin_forums );
			}

			// Done
			Forum.Redirect( Pages.admin_editforum, "f={0}", ForumID );
		}

		private void Cancel_Click( object sender, System.EventArgs e )
		{
			Forum.Redirect( Pages.admin_forums );
		}

		protected void BindData_AccessMaskID( object sender, System.EventArgs e )
		{
			( ( DropDownList ) sender ).DataSource = DB.accessmask_list( PageBoardID, null );
			( ( DropDownList ) sender ).DataValueField = "AccessMaskID";
			( ( DropDownList ) sender ).DataTextField = "Name";
		}

		private void InitializeComponent()
		{

		}

		protected void SetDropDownIndex( object sender, System.EventArgs e )
		{
			try
			{
				DropDownList list = ( DropDownList ) sender;
				list.Items.FindByValue( list.Attributes ["value"] ).Selected = true;
			}
			catch ( Exception )
			{
			}
		}
	}
}
