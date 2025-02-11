using hajUsput.Model;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;
using System.Runtime.InteropServices;

namespace HajUsput.Filters
{
    public class ErrorFilter : ExceptionFilterAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            if (context.Exception is UserException)
            {
                context.ModelState.AddModelError("userError", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }
            else
            {
                context.ModelState.AddModelError("ERROR", "Server side error");
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            }



            var list = context.ModelState.Where(x => x.Value.Errors.Count() > 0)
                .ToDictionary(x => x.Key, y => y.Value.Errors.Select(z => z.ErrorMessage));


            context.Result = new JsonResult(new { errors = list });
        }
        // ERROR FIX
        //public override void OnException(ExceptionContext context)
        //{
        //    var exception = context.Exception;
        //    var statusCode = exception is UserException ? HttpStatusCode.BadRequest : HttpStatusCode.InternalServerError;

        //    var errorDetails = new
        //    {
        //        message = exception.Message,
        //        type = exception.GetType().Name,
        //        status = (int)statusCode,
        //        path = context.HttpContext.Request.Path,
        //        method = context.HttpContext.Request.Method,
        //        timestamp = DateTime.UtcNow,
        //        stackTrace = exception.StackTrace,
        //        innerException = exception.InnerException?.Message
        //    };

        //    context.HttpContext.Response.StatusCode = (int)statusCode;
        //    context.Result = new JsonResult(errorDetails);
        //}
    }
}
