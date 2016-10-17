using System.ServiceModel;

namespace Recipe8
{
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        void InsertTestRecord();

        [OperationContract]
        Client GetClient();

        [OperationContract]
        void Update(Client client);
    }
}