using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainReservation
{
	public enum ChangeAction
	{
		Insert,
		Update,
		Delete
	}

	interface IValidate
	{
		void Validate(ChangeAction action);
	}
}
