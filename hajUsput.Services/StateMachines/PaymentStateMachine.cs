using Stateless;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services.StateMachines
{
    public class PaymentStateMachine
    {
        public enum PaymentState
        {
            Pending,
            Completed,
            Failed
        }

        public enum PaymentTrigger
        {
            Complete,
            Fail
        }

        private readonly StateMachine<PaymentState, PaymentTrigger> _machine;

        public PaymentState CurrentState => _machine.State;

        public PaymentStateMachine(PaymentState initialState = PaymentState.Pending)
        {
            _machine = new StateMachine<PaymentState, PaymentTrigger>(initialState);

            _machine.Configure(PaymentState.Pending)
                .Permit(PaymentTrigger.Complete, PaymentState.Completed)
                .Permit(PaymentTrigger.Fail, PaymentState.Failed);

            _machine.Configure(PaymentState.Completed)
                .Ignore(PaymentTrigger.Fail);

            _machine.Configure(PaymentState.Failed)
                .Ignore(PaymentTrigger.Complete);
        }

        public void Complete() => _machine.Fire(PaymentTrigger.Complete);
        public void Fail() => _machine.Fire(PaymentTrigger.Fail);
    }
}
