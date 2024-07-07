using Stateless;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services.StateMachines
{
    public class BookingStateMachine
    {
        public enum BookingState
        {
            Pending,
            Confirmed,
            Cancelled,
            Completed
        }

        public enum BookingTrigger
        {
            Confirm,
            Cancel,
            Complete
        }

        private readonly StateMachine<BookingState, BookingTrigger> _machine;

        public BookingState CurrentState => _machine.State;

        public BookingStateMachine(BookingState initialState = BookingState.Pending)
        {
            _machine = new StateMachine<BookingState, BookingTrigger>(initialState);

            _machine.Configure(BookingState.Pending)
                .Permit(BookingTrigger.Confirm, BookingState.Confirmed)
                .Permit(BookingTrigger.Cancel, BookingState.Cancelled);

            _machine.Configure(BookingState.Confirmed)
                .Permit(BookingTrigger.Complete, BookingState.Completed)
                .Permit(BookingTrigger.Cancel, BookingState.Cancelled);

            _machine.Configure(BookingState.Completed)
                .Ignore(BookingTrigger.Cancel);

            _machine.Configure(BookingState.Cancelled)
                .Ignore(BookingTrigger.Confirm)
                .Ignore(BookingTrigger.Complete);
        }

        public void Confirm() => _machine.Fire(BookingTrigger.Confirm);
        public void Cancel() => _machine.Fire(BookingTrigger.Cancel);
        public void Complete() => _machine.Fire(BookingTrigger.Complete);
    }
}
