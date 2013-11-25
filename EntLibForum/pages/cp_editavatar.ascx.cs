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

namespace yaf.pages
{
	public partial class cp_editavatar : ForumPage
	{
		public cp_editavatar()
			: base( "CP_EDITAVATAR" )
		{
		}

		protected void Page_Load( object sender, EventArgs e )
		{
			if ( !User.IsAuthenticated )
			{
				if ( User.CanLogin )
					Forum.Redirect( Pages.login, "ReturnUrl={0}", Utils.GetSafeRawUrl() );
				else
					Forum.Redirect( Pages.forum );
			}

			if ( !IsPostBack )
			{
				PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
				PageLinks.AddLink( PageUserName, Forum.GetLink( Pages.cp_profile ) );
				PageLinks.AddLink( GetText( "TITLE" ), "" );
			}
		}
	}
}