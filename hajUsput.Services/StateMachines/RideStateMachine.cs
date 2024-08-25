using Stateless;

public class RideStateMachine
{
    public enum State
    {
        Scheduled,
        Full,
        Cancelled,
        Archived
    }

    public enum Trigger
    {
        FillSeats,
        CancelRide,
        ArchiveRide
    }

    private readonly StateMachine<State, Trigger> _stateMachine;

    public State CurrentState => _stateMachine.State;

    public RideStateMachine(State initialState = State.Scheduled)
    {
        _stateMachine = new StateMachine<State, Trigger>(initialState);

        _stateMachine.Configure(State.Scheduled)
            .Permit(Trigger.FillSeats, State.Full)
            .Permit(Trigger.CancelRide, State.Cancelled)
            .Permit(Trigger.ArchiveRide, State.Archived);

        _stateMachine.Configure(State.Full)
            .Permit(Trigger.CancelRide, State.Cancelled)
            .Permit(Trigger.ArchiveRide, State.Archived);

        _stateMachine.Configure(State.Cancelled)
            .Ignore(Trigger.FillSeats)
            .Ignore(Trigger.ArchiveRide);

        _stateMachine.Configure(State.Archived)
            .Ignore(Trigger.FillSeats)
            .Ignore(Trigger.CancelRide);
    }

    public void FillSeats() => _stateMachine.Fire(Trigger.FillSeats);
    public void CancelRide() => _stateMachine.Fire(Trigger.CancelRide);
    public void ArchiveRide() => _stateMachine.Fire(Trigger.ArchiveRide);
}
