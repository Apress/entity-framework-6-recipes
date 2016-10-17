using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
namespace TrainReservation
{
	public class FakeReservationContext : IReservationContext, IDisposable
	{
		private IDbSet<Train> trains;
		private IDbSet<Schedule> schedules;
		private IDbSet<Reservation> reservations;
		public FakeReservationContext()
		{
			trains = new FakeDbSet<Train>();
			schedules = new FakeDbSet<Schedule>();
			reservations = new FakeDbSet<Reservation>();
		}

		public IDbSet<Train> Trains
		{
			get { return trains; }
		}

		public IDbSet<Schedule> Schedules
		{
			get { return schedules; }
		}

		public IDbSet<Reservation> Reservations
		{
			get { return reservations; }
		}

		public int SaveChanges()
		{
			foreach (var schedule in Schedules.Cast<IValidate>())
			{
				schedule.Validate(ChangeAction.Insert);
			}
			foreach (var reservation in Reservations.Cast<IValidate>())
			{
				reservation.Validate(ChangeAction.Insert);
			}
			return 1;
		}
		public void Dispose()
		{
		}
	}
}
