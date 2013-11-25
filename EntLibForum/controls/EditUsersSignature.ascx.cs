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
	public partial class EditUsersSignature : BaseUserControl
	{
		protected yaf.editor.ForumEditor sig;
		private int CurrentUserID;
		private bool AdminEditMode = false;

		protected void Page_Load( object sender, EventArgs e )
		{
			if ( AdminEditMode && ForumPage.IsAdmin && Request.QueryString ["u"] != null )
			{
				CurrentUserID = Convert.ToInt32( Request.QueryString ["u"] );
			}
			else
			{
				CurrentUserID = ForumPage.PageUserID;
			}

			sig.BaseDir = Data.ForumRoot + "editors";
			sig.StyleSheet = ForumPage.ThemeFile( "theme.css" );

			if ( !IsPostBack )
			{
				sig.Text = DB.user_getsignature( CurrentUserID );

				save.Text = ForumPage.GetText( "COMMON", "Save" );
				cancel.Text = ForumPage.GetText( "COMMON", "Cancel" );
			}
		}

		private void save_Click( object sender, EventArgs e )
		{
			string body = sig.Text;
			//body = FormatMsg.RepairHtml(this,body,false);

			if ( sig.Text.Length > 0 )
				DB.user_savesignature( CurrentUserID, body );
			else
				DB.user_savesignature( CurrentUserID, DBNull.Value );

			if ( AdminEditMode )
				Forum.Redirect( Pages.admin_users );
			else
				Forum.Redirect( Pages.cp_profile );
		}

		private void cancel_Click( object sender, EventArgs e )
		{
			if ( AdminEditMode )
				Forum.Redirect( Pages.admin_users );
			else
				Forum.Redirect( Pages.cp_profile );
		}

		#region Web Form Designer generated code
		override protected void OnInit( EventArgs e )
		{
			// since signatures are so small only allow BBCode in them...
			sig = new yaf.editor.BBCodeEditor();
			EditorLine.Controls.Add( sig );

			save.Click += new EventHandler( save_Click );
			cancel.Click += new EventHandler( cancel_Click );
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

		public bool InAdminPages
		{
			get
			{
				return AdminEditMode;
			}
			set
			{
				AdminEditMode = value;
			}
		}
	}
}