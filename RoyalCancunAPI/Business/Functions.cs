using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RoyalCancunAPI.Business
{
    public class Functions
    {
        public List<string> getMiddleDates(string start, string end) {
            List<string> dates = new List<string>();
            for (DateTime x = DateTime.Parse(start); x <= DateTime.Parse(end); x = x.AddDays(1.0))
            {
                dates.Add(x.ToString("yyyy'-'MM'-'dd"));
            }
            return dates;
        }
    }
}
