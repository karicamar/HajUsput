using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface ICarMakeService : ICRUDService<CarMake,CarMakeSearchObject, CarMakeUpsertRequest, CarMakeUpsertRequest>
    {
    }
}