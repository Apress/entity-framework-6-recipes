using System.Data;

namespace Recipe4.Service.DAL
{
    public class EntityStateFactory
    {
        public static EntityState Set(TrackingState trackingState)
        {
            switch (trackingState)
            {
                case TrackingState.Add:
                    return EntityState.Added;
                case TrackingState.Update:
                    return EntityState.Modified;
                case TrackingState.Remove:
                    return EntityState.Deleted;
                default:
                    return EntityState.Unchanged;
            }
        }
    }
}