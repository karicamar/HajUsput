
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize(Roles = "User,Admin")]

    public class PaymentController : BaseCRUDController<Payment, hajUsput.Model.SearchObjects.PaymentSearchObject, hajUsput.Model.Requests.PaymentInsertRequest, hajUsput.Model.Requests.PaymentUpdateRequest>

    {
        private readonly IPaymentService _paymentService;
        public PaymentController(ILogger<BaseController<Payment, hajUsput.Model.SearchObjects.PaymentSearchObject>> logger, IPaymentService service) : base(logger,service)
        {
            _paymentService = service;
        }
        [HttpPost("create-payment-intent")]
        public IActionResult CreatePaymentIntent([FromBody] PaymentIntentRequest request)
        {
            var paymentIntent = _paymentService.CreatePaymentIntent(request.Amount, request.Currency);
            return Ok(new { clientSecret = paymentIntent.ClientSecret });
        }
        [HttpPost("confirm-payment/{paymentId}")]
        public IActionResult CompletePayment(int paymentId)
        {
            try
            {
                _paymentService.CompletePayment(paymentId);
                return Ok("Payment completed successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest($"Failed to comple payment: {ex.Message}");
            }
        }
        [HttpPost("fail-payment/{paymentId}")]
        public IActionResult FailPayment(int paymentId)
        {
            try
            {
                _paymentService.FailPayment(paymentId);
                return Ok("Payment failed.");
            }
            catch (Exception ex)
            {
                return BadRequest($"Failed to fail payment: {ex.Message}");
            }
        }
        [HttpGet("total-revenue")]
        public async Task<IActionResult> GetTotalRevenue([FromQuery] PaymentSearchObject search)
        {
            try
            {
                var totalRevenue = await _paymentService.GetTotalRevenue(search);
                return Ok(totalRevenue);
            }
            catch (Exception ex)
            {
                return BadRequest($"Failed to retrieve total revenue: {ex.Message}");
            }
        }
        [HttpPost("generate-financial-report-pdf")]
        public IActionResult GenerateFinancialReportPdf([FromBody] PaymentSearchObject search)
        {
            try
            {
                var pdfBytes = _paymentService.GenerateFinancialReportPdf(search);
                return File(pdfBytes, "application/pdf", "FinancialReport.pdf");
            }
            catch (Exception ex)
            {
                return BadRequest($"Failed to generate financial report PDF: {ex.Message}");
            }
        }

    }
}
