using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace TrainReservation
{
	public interface IReservationContext : IDisposable
	{
		IDbSet<Train> Trains { get; }
		IDbSet<Schedule> Schedules { get; }
		IDbSet<Reservation> Reservations { get; }
		int SaveChanges();
	}
}
