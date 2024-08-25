using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using Stripe;

namespace hajUsput.Services
{
    public interface IPaymentService : ICRUDService<Payment, PaymentSearchObject, PaymentInsertRequest, PaymentUpdateRequest>
    {
         PaymentIntent CreatePaymentIntent(decimal amount, string currency = "bam");
        void CompletePayment(int paymentId);
        void FailPayment(int paymentId);
        public Task<decimal> GetTotalRevenue(PaymentSearchObject? search = null);

        byte[] GenerateFinancialReportPdf(PaymentSearchObject search);
    }
}