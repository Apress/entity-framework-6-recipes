using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Recipe4.Client
{
    class BaseEntity
    {
        protected BaseEntity()
        {
            TrackingState = TrackingState.Nochange;
        }

        public TrackingState TrackingState { get; set; }
    }
}
