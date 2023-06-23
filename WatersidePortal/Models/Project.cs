using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WatersidePortal.Models
{
    /// <summary>
    /// Customer Project. Also know as a Bid Proposal.
    /// </summary>
    public class Project
    {
        public string sItems;
        public int projectID;
        public int lengthF;
        public int lengthI;
        public int widthF;
        public int widthI;
        public string projectName;
        public string projectDescription;
        public Item items;
    }
}