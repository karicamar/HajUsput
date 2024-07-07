using Stateless;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services.StateMachines
{
    public class RideStateMachine
    {
        public enum State
        {
            Scheduled,
            InProgress,
            Completed,
            Cancelled
        }

        public enum Trigger
        {
            StartRide,
            CompleteRide,
            CancelRide
        }
        private StateMachine<State, Trigger> _stateMachine;

        public State CurrentState => _stateMachine.State;

        public RideStateMachine()
        {
            _stateMachine = new StateMachine<State, Trigger>(State.Scheduled);

            _stateMachine.Configure(State.Scheduled)
                .Permit(Trigger.StartRide, State.InProgress)
                .Permit(Trigger.CancelRide, State.Cancelled);

            _stateMachine.Configure(State.InProgress)
                .Permit(Trigger.CompleteRide, State.Completed)
                .Permit(Trigger.CancelRide, State.Cancelled);

            _stateMachine.Configure(State.Completed)
                .Ignore(Trigger.StartRide)
                .Ignore(Trigger.CompleteRide)
                .Ignore(Trigger.CancelRide);

            _stateMachine.Configure(State.Cancelled)
                .Ignore(Trigger.StartRide)
                .Ignore(Trigger.CompleteRide)
                .Ignore(Trigger.CancelRide);
        }

        public void StartRide()
        {
            _stateMachine.Fire(Trigger.StartRide);
        }

        public void CompleteRide()
        {
            _stateMachine.Fire(Trigger.CompleteRide);
        }

        public void CancelRide()
        {
            _stateMachine.Fire(Trigger.CancelRide);
        }
    }
}
