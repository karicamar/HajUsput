using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IGenderService : ICRUDService<Gender,BaseSearchObject,GenderUpsertRequest, GenderUpsertRequest>
    {
    }
}