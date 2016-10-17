using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TrainReservation;

namespace Tests
{
	[TestClass]
	public class ReservationTest
	{
		private IReservationContext _context;

		[TestInitialize]
		public void TestSetup()
		{
			var train = new Train { TrainId = 1, TrainName = "Polar Express" };
			var schedule = new Schedule
			{
				ScheduleId = 1,
				Train = train,
				ArrivalDate = DateTime.Now,
				DepartureDate = DateTime.Today,
				LeavesFrom = "Dallas",
				ArrivesAt = "New York"
			};
			var reservation = new Reservation
			{
				ReservationId = 1,
				Passenger = "Phil Marlowe",
				Schedule = schedule
			};
			_context = new FakeReservationContext();
			var repository = new ReservationRepository(_context);
			repository.AddTrain(train);
			repository.AddSchedule(schedule);
			repository.AddReservation(reservation);
			repository.SaveChanges();
		}

		[TestMethod]
		[ExpectedException(typeof(InvalidOperationException))]
		public void TestForDuplicateReservation()
		{
			var repository = new ReservationRepository(_context);
			var schedule = repository.GetActiveSchedulesForTrain(1).First();
			var reservation = new Reservation
			{
				ReservationId = 2,
				Schedule = schedule,
				Passenger = "Phil Marlowe"
			};
			repository.AddReservation(reservation);
			repository.SaveChanges();
		}

		[TestMethod]
		[ExpectedException(typeof(InvalidOperationException))]
		public void TestForArrivalDateGreaterThanDepartureDate()
		{
			var repository = new ReservationRepository(_context);
			var schedule = new Schedule
			{
				ScheduleId = 2,
				TrainId = 1,
				ArrivalDate = DateTime.Today,
				DepartureDate = DateTime.Now,
				ArrivesAt = "New York",
				LeavesFrom = "Chicago"
			};
			repository.AddSchedule(schedule);
			repository.SaveChanges();
		}

		[TestMethod]
		[ExpectedException(typeof(InvalidOperationException))]
		public void TestForArrivesAndLeavesFromSameLocation()
		{
			var repository = new ReservationRepository(_context);
			var schedule = new Schedule
			{
				ScheduleId = 3,
				TrainId = 1,
				ArrivalDate = DateTime.Now,
				DepartureDate = DateTime.Today,
				ArrivesAt = "Dallas",
				LeavesFrom = "Dallas"
			};
			repository.AddSchedule(schedule);
			repository.SaveChanges();
		}
	}
}
