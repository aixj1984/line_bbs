using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Trilink.Common
{
    public class Foot : ITemplate
    {
        private string link="</ul>";
        public string Link
        {
            set { link = value; }
            get { return link; }
        }

        public void InstantiateIn(Control container)
        {
            Label lbl=new Label();
            lbl.Text=link;
            container.Controls.Add(lbl);
        }
    }
}
