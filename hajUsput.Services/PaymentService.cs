
using AutoMapper;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.Database;
using hajUsput.Services.StateMachines;
using iTextSharp.text.pdf;
using Microsoft.EntityFrameworkCore;
using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class PaymentService : BaseCRUDService<Model.Payment, Database.Payment, PaymentSearchObject, PaymentInsertRequest, PaymentUpdateRequest>, IPaymentService
    {

        public PaymentService(_180072Context context, IMapper mapper) : base(context, mapper)
        {
            StripeConfiguration.ApiKey =  Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY");
            
        }
        public PaymentIntent CreatePaymentIntent(decimal amount, string currency = "bam")
        {
            var options = new PaymentIntentCreateOptions
            {
                Amount = (long)(amount * 100), // Stripe uses cents
                Currency = currency,
                PaymentMethodTypes = new List<string> { "card" },
            };

            var service = new PaymentIntentService();
            return service.Create(options);
        }
        public void UpdatePaymentStatus(int paymentId, PaymentStateMachine.PaymentTrigger trigger)
        {
            var payment = _context.Payments.Find(paymentId);
            if (payment == null)
                throw new Exception("Payment not found");

            var paymentStateMachine = new PaymentStateMachine((PaymentStateMachine.PaymentState)Enum.Parse(typeof(PaymentStateMachine.PaymentState), payment.PaymentStatus));

            switch (trigger)
            {
                case PaymentStateMachine.PaymentTrigger.Complete:
                    paymentStateMachine.Complete();
                    break;
                case PaymentStateMachine.PaymentTrigger.Fail:
                    paymentStateMachine.Fail();
                    break;
            }

            payment.PaymentStatus = paymentStateMachine.CurrentState.ToString();

            _context.SaveChanges();
        }

        public void CompletePayment(int paymentId)
        {
            var payment = _context.Payments.Find(paymentId);
            if (payment == null)
                throw new Exception("Payment not found");

            UpdatePaymentStatus(paymentId, PaymentStateMachine.PaymentTrigger.Complete);

            _context.SaveChanges();
        }

        public void FailPayment(int paymentId)
        {
            var payment = _context.Payments.Find(paymentId);
            if (payment == null)
                throw new Exception("Payment not found");

            UpdatePaymentStatus(paymentId, PaymentStateMachine.PaymentTrigger.Fail);

            _context.SaveChanges();
        }
        
        public async Task<decimal> GetTotalRevenue(PaymentSearchObject? search = null)
        {
            var query = _context.Payments.AsQueryable();
            if (search != null)
            {
                query = AddFilter(query, search);
            }

            var totalRevenue = await query.SumAsync(p => p.Amount ?? 0);
            return totalRevenue;
        }
        public override IQueryable<Payment> AddFilter(IQueryable<Payment> query, PaymentSearchObject? search = null)
        {
            query = base.AddFilter(query, search);

            if (search?.StartDate.HasValue ?? false)
            {
                query = query.Where(x => x.PaymentDate >= search.StartDate.Value);
            }

            if (search?.EndDate.HasValue ?? false)
            {
                query = query.Where(x => x.PaymentDate <= search.EndDate.Value);
            }

            if (!string.IsNullOrEmpty(search?.PaymentStatus))
            {
                query = query.Where(x => x.PaymentStatus == search.PaymentStatus);
            }

            if (!string.IsNullOrEmpty(search?.PaymentMethod))
            {
                query = query.Where(x => x.PaymentMethod == search.PaymentMethod);
            }

            return query;
        }
        
        public byte[] GenerateFinancialReportPdf(PaymentSearchObject search)
        {
            var payments = _context.Payments.AsQueryable();
            payments = AddFilter(payments, search);

            using (var memoryStream = new MemoryStream())
            {
                // Use fully qualified name to avoid ambiguity
                iTextSharp.text.Document document = new iTextSharp.text.Document();
                PdfWriter.GetInstance(document, memoryStream);
                document.Open();

                // Add content to PDF
                AddContentToPdf(document, payments.ToList());

                document.Close();
                return memoryStream.ToArray();
            }
        }


        private void AddContentToPdf(iTextSharp.text.Document document, List<Payment> payments)
        {
            // Add Title
            document.Add(new iTextSharp.text.Paragraph("Financial Report"));
            document.Add(new iTextSharp.text.Paragraph("Generated on: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm")));
            document.Add(new iTextSharp.text.Paragraph("\n"));

            // Add table with additional columns for Status and Method
            PdfPTable table = new PdfPTable(5); // Updated to 5 columns
            table.AddCell("Payment ID");
            table.AddCell("Amount");
            table.AddCell("Date");
            table.AddCell("Status");
            table.AddCell("Method");

            // Add data rows
            foreach (var payment in payments)
            {
                table.AddCell(payment.PaymentId.ToString());
                table.AddCell(payment.Amount.ToString());
                table.AddCell(payment.PaymentDate.Value.ToString("dd/MM/yyyy"));
                table.AddCell(payment.PaymentStatus);  // Assuming PaymentStatus is a string
                table.AddCell(payment.PaymentMethod);  // Assuming PaymentMethod is a string
            }

            document.Add(table);

            // Add a summary section
            document.Add(new iTextSharp.text.Paragraph("\nSummary:"));
            document.Add(new iTextSharp.text.Paragraph("Total Payments: " + payments.Count));
            document.Add(new iTextSharp.text.Paragraph("Total Amount: $" + payments.Sum(p => p.Amount).ToString()));
        }

    }
}
