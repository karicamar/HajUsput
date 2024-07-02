﻿using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IPaymentService : ICRUDService<Payment, BaseSearchObject, PaymentInsertRequest, PaymentUpdateRequest>
    {
    }
}