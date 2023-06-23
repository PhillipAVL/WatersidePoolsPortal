using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WatersidePortal.Models
{
    /// <summary>
    /// Project item.
    /// </summary>
    public class Item
    {
        public bool optional;
        public string item;
        public string unit;
        public string status;
        public int quantity;
        public int itemID;
        public string description;
        public float price;
        public float overage;
        public DateTime lockedTime;
        public float currPrice;
        public string category;
        public string subcategory;
        public string subsubcategory;
    }
}