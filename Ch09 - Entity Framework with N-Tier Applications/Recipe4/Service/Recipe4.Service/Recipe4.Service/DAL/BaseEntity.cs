namespace Recipe4.Service.DAL
{
    public abstract class BaseEntity
    {
        protected BaseEntity()
        {
            TrackingState = TrackingState.Nochange;
        }

        public TrackingState TrackingState { get; set; }
    }
}